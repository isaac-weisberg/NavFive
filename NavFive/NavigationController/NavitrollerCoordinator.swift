import UIKit
import RxSwift
import RxCocoa

public struct NavitrollerCoordinator<NavigationState: ArrayControllerConvertible, Action> {
    public typealias View = NavitrollerCoordinated
    
    struct State {
        let viewState: View.State?
        let lastAction: Action
    }
    
    public let view: View
    
    public let actionPublish: PublishRelay<Action>
    
    public let start: Driver<Void>
    
    public init(view: View, initial action: Action, _ converter: @escaping (Action, PublishRelay<Action>, View.State?) -> View.State) {
        self.view = view
        let actionPublish = PublishRelay<Action>()
        self.actionPublish = actionPublish
        let navStateFlow = actionPublish
            .startWith(action)
            .withLatestFrom(view.coordinationState.asDriver()) { ($0, $1) }
            .map { action, state in
                State(viewState: converter(action, actionPublish, state), lastAction: action)
        }
        
        let ending = navStateFlow
            .takeLast(1)
            .map { state in
                State(viewState: nil, lastAction: state.lastAction)
        }
        
        start = navStateFlow
            .concat(ending)
            .asDriver(onErrorRecover: { _ in .never() })
            .do(onNext: { state in
                view.coordinationState.accept(state.viewState)
            })
            .asDriver()
    }
}

