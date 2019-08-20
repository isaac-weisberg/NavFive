import UIKit
import NavFive

enum AppCoordinator {
    typealias Instance = SequetialCoordinator<State, Action>
    
    enum State: NaviUnitConvertible {
        case main(MainCoordinator.Instance)
        
        var naviUnit: SequentialNaviUnit {
            switch self {
            case .main(let coordinator):
                return .child(coordinator.view)
            }
        }
    }
    
    enum Action {
        case run
    }
    
    static func make(view: SequentialWindow) -> Instance {
        return Instance(view: view, initial: .run) { action, dispatch, state in
            switch action {
            case .run:
                let navitroller = SequentialNavitroller()
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
