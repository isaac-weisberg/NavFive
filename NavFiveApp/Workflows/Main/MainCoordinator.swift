import UIKit
import NavFive

struct MainCoordinator {
    typealias Instance = WindowCoordinator<NavigationState, Action>
    
    enum NavigationState: WindowNavigationState {
        case main(MainViewController)
        
        var asViewController: UIViewController {
            switch self {
            case .main(let controller):
                return controller
            }
        }
    }
    
    enum Action {
        case showMain
    }
    
    static func make(window: UIWindow) -> Instance {
        return WindowCoordinator(router: window, initial: .showMain) { action, state in
            switch action {
            case .showMain:
                let controller = MainViewController()
                
                return .main(controller)
            }
        }
    }
}
