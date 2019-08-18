import UIKit
import RxSwift
import RxCocoa

struct Coordinator<View: CoordinatedView, NaviState: NaviUnitConvertible, Action> {
    public struct State {
        public let state: NaviState?
        public let lastAction: Action
    }
    
    public let view: View
    public let actionPublish: PublishRelay<Action>
    public let start: Driver<Void>
    
    public init(view: View, initial action: Action, _ converter: @escaping (Action, PublishRelay<Action>, NaviState?) -> NaviState) {
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
            .map { _ in () }
    }
}

