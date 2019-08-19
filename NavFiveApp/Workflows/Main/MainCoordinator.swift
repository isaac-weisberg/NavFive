import UIKit
import NavFive

enum MainCoordinator {
    typealias Instance = NavitrollerCoordinator<NavigationState, Action>
    
    struct NavigationState: NaviUnitArrayConvertible {
        enum Step {
            case main(MainViewController)
        }
        
        let steps: [Step]
        
        var naviUnits: [NaviUnit] {
            return steps.map { step in
                switch step {
                case .main(let controller):
                    return controller
                }
            }
        }
    }
    
    typealias Action = AppCoordinator.Action
    
    static func make(view: NavitrollerCoordinated) -> Instance {
        return Instance(view: view, initial: .run) { action, dispatch, state in
            switch action {
            case .run:
                let controller = MainViewController()
                return NavigationState(steps: [ .main(controller) ])
            }
        }
    }
}
