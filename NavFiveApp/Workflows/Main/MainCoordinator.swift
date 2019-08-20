import UIKit
import NavFive

enum MainCoordinator {
    typealias Instance = SequetialCoordinator<NavigationState, Action>
    
    struct NavigationState: NaviUnitConvertible {
        enum Step {
            case main(MainViewController)
        }
        
        let steps: [Step]
        
        var naviUnit: SequentialNaviUnit {
            return .many(steps.map { step in
                switch step {
                case .main(let controller):
                    return .one(controller)
                }
            })
        }
    }
    
    typealias Action = AppCoordinator.Action
    
    static func make(view: SequentialNavitroller) -> Instance {
        return Instance(view: view, initial: .run) { action, dispatch, state in
            switch action {
            case .run:
                let controller = MainViewController()
                return NavigationState(steps: [ .main(controller) ])
            }
        }
    }
}
