import NavFive
import UIKit

struct MainCoordinator {
    enum Action {
        case main
        case detail
    }
    
    struct State: NaviUnitConvertible {
        enum Step {
            case main(TopViewController)
            case detail(DetailViewController)
        }
        
        let steps: [Step]
        
        var naviUnit: SequentialNaviUnit {
            let controllers = steps
                .map { step -> SequentialNaviUnit in
                    switch step {
                    case .main(let controller):
                        return SequentialNaviUnit.one(controller)
                    case .detail(let controller):
                        return SequentialNaviUnit.one(controller)
                    }
                }
            
            return .many(controllers)
        }
    }
    
    typealias Instance = SequetialCoordinator<State, Action>
    
    static func make(view: SequentialNavitroller) -> Instance {
        return Instance(view: view, initial: .main) { action, dispatcher, state in
            switch action {
            case .main:
                let controller = TopViewController()
                
                controller.proceedRequested
                    .map {
                        Action.detail
                    }
                    .bind(to: dispatcher)
                    .disposed(by: controller.disposeBag)
                
                let step = [State.Step.main(controller)]
                let newSteps = { () -> [MainCoordinator.State.Step] in
                    if let oldSteps = state?.steps {
                        return oldSteps + step
                    }
                    return step
                }()
                return State(steps: newSteps)
            case .detail:
                let controller = DetailViewController()
                let step = [State.Step.detail(controller)]
                let newSteps = { () -> [MainCoordinator.State.Step] in
                    if let oldSteps = state?.steps {
                        return oldSteps + step
                    }
                    return step
                }()
                return State(steps: newSteps)
            }
        }
    }
}
