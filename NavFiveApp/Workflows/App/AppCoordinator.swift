import UIKit
import NavFive

enum AppCoordinator {
    typealias Instance = WindowCoordinator<State, Action>
    
    enum State: WindowNavigationState {
        case main(MainCoordinator.Instance)
        
        var asViewController: UIViewController {
            switch self {
            case .main(let coordinator):
                let controller = coordinator.view
                coordinator.state
                    .drive()
                    .disposed(by: controller.naviSposeBag)
                
                return controller
            }
        }
    }
    
    enum Action {
        case run
    }
    
    static func make(view: Instance.View) -> Instance {
        return Instance(view: view, initial: .run) { action, dispatch, state in
            switch action {
            case .run:
                let navitroller = MainCoordinator.Instance.View()
                let coordinator = MainCoordinator.make(view: navitroller)
                return .main(coordinator)
            }
        }
    }
}
