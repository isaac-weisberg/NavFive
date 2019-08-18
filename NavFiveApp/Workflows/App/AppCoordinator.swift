import UIKit
import NavFive

enum AppCoordinator {
    typealias Instance = WindowCoordinator<State, Action>
    
    enum State: WindowNaviState {
        case main(MainCoordinator.Instance)
        
        var naviUnit: NaviUnit {
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
    
    static func make(view: WindowCoordinated) -> Instance {
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
