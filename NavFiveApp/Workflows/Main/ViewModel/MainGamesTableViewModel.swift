import UIKit
import RxSwift
import RxCocoa

protocol MainGamesTableViewModelProtocol {
    var state: Driver<MainGamesTableViewModelState> { get }
}

enum MainGamesTableViewModelState {
    case loaded([GameCellViewModelProtocol])
}

struct MainGamesTableViewModel {
    let state: Driver<MainGamesTableViewModelState>
    
    init() {
        let dataSet = [
            "Battlefront II",
            "Knack 2",
            "Petscop",
            "Minecraft"
        ].map(GameCellViewModel.init(title:))
        
        state = .just(.loaded(dataSet))
    }
}

extension MainGamesTableViewModel: MainGamesTableViewModelProtocol {
    
}
