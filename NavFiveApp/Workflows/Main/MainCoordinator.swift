import UIKit
import NavFive

enum MainCoordinator {
    typealias Instance = SequetialCoordinator<NavigationState, Action>
    
    struct NavigationState: NaviUnitConvertible {
        enum Step {
            case main(UIViewController)
        }
        
        let steps: [Step]
        
        var naviUnit: SequentialNaviUnit {
            let units: [SequentialNaviUnit] = steps.map { step in
                switch step {
                case .main(let controller):
                    return .one(controller)
                }
            }
            
            return .many(units)
        }
    }
    
    typealias Action = AppCoordinator.Action
    
    static func make(view: SequentialNavitroller) -> Instance {
        return Instance(view: view, initial: .run) { action, dispatch, state in
            switch action {
            case .run:
                let controller = UIViewController(nibName: nil, bundle: nil)
                controller.view.backgroundColor = .green
                return NavigationState(steps: [ .main(controller) ])
            }
        }
    }
}
