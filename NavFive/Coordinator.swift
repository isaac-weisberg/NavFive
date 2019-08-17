import UIKit
import RxSwift
import RxCocoa

public struct Coordinator<AView: CoordinatedView, Action> {
    public typealias View = AView
    
    public struct State {
        public let viewState: ViewState<View.NavigationState>
        public let lastAction: Action
    }
    
    public let actionPublish: PublishRelay<Action>
    
    public let state: Driver<State>
    
    public init(view: View, initial action: Action, _ converter: @escaping (Action, PublishRelay<Action>, ViewState<View.NavigationState>) -> View.NavigationState) {
        let actionPublish = PublishRelay<Action>()
        self.actionPublish = actionPublish
        let navStateFlow = actionPublish
            .startWith(action)
            .withLatestFrom(view.coordinationState.asDriver()) { ($0, $1) }
            .map { action, state in
                State(viewState: .coordinated(converter(action, actionPublish, state)), lastAction: action)
            }
        
        let ending = navStateFlow
            .takeLast(1)
            .map { state in
                State(viewState: .uncoordinated, lastAction: state.lastAction)
            }
        
        state = navStateFlow
            .concat(ending)
            .asDriver(onErrorRecover: { _ in .never() })
            .do(onNext: { state in
                view.coordinationState.accept(state.viewState)
            })
    }
}

