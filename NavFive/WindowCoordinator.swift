import UIKit
import RxSwift
import RxCocoa

public struct WindowCoordinator<NavigationState: WindowNavigationState, Action> {
    struct State {
        let viewState: ViewState<NavigationState>
        let lastAction: Action
    }
    
    public let actionPublish = PublishRelay<Action>()
    
    public let state: Driver<NavigationState>
    
    public init(router: WindowCoordinated<NavigationState>, initial action: Action, _ converter: @escaping (Action, ViewState<NavigationState>) -> NavigationState) {
        actionPublish
            .startWith(action)
            .withLatestFrom(router.state) { ($0, $1) }
            .map { action, state in
                converter(action, state)
            }
            .map { state in
                ViewState<NavigationState>.coordinated(state)
            }
            .concat(Observable.just(WindowCoordinated<NavigationState>.State.uncoordinated))
            .do(onNext: { state in
                router.state.accept(state)
            })
    }
}
