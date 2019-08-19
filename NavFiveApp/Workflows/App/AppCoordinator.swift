import UIKit
import NavFive

enum AppCoordinator {
    typealias Instance = WindowCoordinator<State, Action>
    
    enum State: NaviUnitConvertible {
        case main(MainCoordinator.Instance)
        
        var naviUnit: NaviUnit {
            switch self {
            case .main(let coordinator):
                let controller = coordinator.view
                
                return controller
            }
        }
    }
    
    enum Action {
        case run
    }
    
    static func make(view: WindowCoordinated) -> Instance {
        return Instance(view: view, initial: .run) { action, dispatch, state in
            switch action {
            case .run:
                let navitroller = NavitrollerCoordinated()
                let coordinator = MainCoordinator.make(view: navitroller)
                
                coordinator.start
                    .asObservable()
                    .bind(to: dispatch)
                    .disposed(by: navitroller.naviSposeBag)
                
                return .main(coordinator)
            }
        }
    }
}
