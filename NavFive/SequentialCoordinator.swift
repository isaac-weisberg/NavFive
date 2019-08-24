import UIKit
import RxSwift
import RxCocoa

public struct SequetialCoordinator<NaviState: NaviUnitConvertible, Action> {
    struct State {
        let state: NaviState
        let lastAction: Action
    }
    
    let stateRelay: BehaviorRelay<State?>
    let actionPublish: PublishRelay<Action>
    public let view: SequentialViewProtocol
    public let start: Driver<Action>
    
    public func publishImperativeAction(_ action: Action) {
        actionPublish.accept(action)
    }
    
    public init(view: SequentialViewProtocol, initial action: Action, _ converter: @escaping (Action, PublishRelay<Action>, NaviState?) -> NaviState) {
        self.view = view
        let actionPublish = PublishRelay<Action>()
        self.actionPublish = actionPublish
        
        let stateRelay = BehaviorRelay<State?>(value: nil)
        self.stateRelay = stateRelay
        
        start = actionPublish
            .asDriver(onErrorRecover: { _ in .never() })
            .startWith(action)
            .withLatestFrom(stateRelay.asDriver()) { ($0, $1) }
            .map { action, state in
                let newNaviState = converter(action, actionPublish, state?.state)
                return State(state: newNaviState, lastAction: action)
            }
            .do(onNext: { state in
                stateRelay.accept(state)
            })
            .flatMapLatest { state in
                state.state.naviUnit.asViewControllers
                    .map { controllers in
                        (controllers, state)
                    }
            }
            .do(onNext: { stuff in
                view.state.accept(stuff.0)
            })
            .map { stuff in
                stuff.1.lastAction
            }
    }
}

