import UIKit
import NavFive

struct MainCoordinator {
    typealias Instance = NavitrollerCoordinator<NavigationState, Action>
    
    struct NavigationState: NavitrollerState {
        enum Step {
            case main(MainViewController)
        }
        
        let steps: [Step]
        
        var asViewControllers: [UIViewController] {
            return steps.map { step in
                switch step {
                case .main(let controller):
                    return controller
                }
            }
        }
    }
    
    enum Action {
        case showMain
    }
    
    static func make(view: Instance.View) -> Instance {
        return Instance(view: view, initial: .showMain) { action, dispatch, state in
            switch action {
            case .showMain:
                let controller = MainViewController()
                return NavigationState(steps: [ .main(controller) ])
            }
        }
    }
}
