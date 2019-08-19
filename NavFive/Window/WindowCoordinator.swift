import UIKit
import RxSwift
import RxCocoa

public struct WindowCoordinator<NaviState: NaviUnitConvertible, Action> {
    struct State {
        let state: NaviState?
        let lastAction: Action
    }
    
    public let view: WindowCoordinated
    let actionPublish: PublishRelay<Action>
    public let start: Driver<Action>
    
    func publishImperativeAction(_ action: Action) {
        actionPublish.accept(action)
    }
    
    public init(view: WindowCoordinated, initial action: Action, _ converter: @escaping (Action, PublishRelay<Action>, NaviState?) -> NaviState) {
        self.view = view
        let actionPublish = PublishRelay<Action>()
        self.actionPublish = actionPublish
        
        let firstNaviState = converter(action, actionPublish, nil)
        let firstState = State(state: firstNaviState, lastAction: action)
        let stateRelay = BehaviorRelay<State>(value: firstState)
        
        let navStateFlow = actionPublish
            .withLatestFrom(stateRelay.asDriver()) { ($0, $1.state) }
            .map { action, state in
                State(state: converter(action, actionPublish, state), lastAction: action)
            }
        
        let ending = navStateFlow
            .takeLast(1)
            .map { state in
                State(state: nil, lastAction: state.lastAction)
            }
        
        start = navStateFlow
            .concat(ending)
            .do(onNext: { state in
                stateRelay.accept(state)
            })
            .asDriver(onErrorRecover: { _ in .never() })
            .do(onNext: { state in
                view.coordinationState.accept(state.state)
            })
            .map { state in
                state.lastAction
            }
    }
}

