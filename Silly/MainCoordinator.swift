import NavFive
import UIKit

struct MainCoordinator {
    enum Action {
        case main
        case detail
    }
    
    struct State: NaviUnitConvertible {
        enum Step {
            case main(UIViewController)
            case detail(UIViewController)
        }
        
        let steps: [Step]
        
        var naviUnit: SequentialNaviUnit {
            let controllers = steps
                .map { step -> SequentialNaviUnit in
                    switch step {
                    case .main(let controller), .detail(let controller):
                        return SequentialNaviUnit.one(controller)
                    }
                }
            
            return .many(controllers)
        }
    }
    
    typealias Instance = SequetialCoordinator<State, Action>
    
    func make(view: SequentialNavitroller) -> Instance {
        return Instance(view: view, initial: .main) { action, dispatcher, state in
            switch action {
            case .main:
                // aw fuck no wait
            }
        }
    }
}
