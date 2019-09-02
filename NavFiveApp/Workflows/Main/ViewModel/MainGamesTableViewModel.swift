import UIKit
import RxSwift
import RxCocoa

protocol MainGamesTableViewModelProtocol {
    var state: Driver<MainGamesTableViewModelState> { get }
}

enum MainGamesTableViewModelState {
    case loaded([GameCellViewModelProtocol])
    case loading
}

struct MainGamesTableViewModel {
    let state: Driver<MainGamesTableViewModelState>
    
    init(interactor: GamesListInteractorProtocol) {
        let cells = interactor.games
            .map { games -> [GameCellViewModel] in
                games.map { model -> GameCellViewModel in
                    GameCellViewModel(model: model)
                }
            }
        
        let call = cells
            .flatMapLatest { (cells: [GameCellViewModel]) -> Observable<String> in
                let selected = cells
                    .map { cell -> Observable<String> in
                        cell.tap
                            .map { () -> String
                                cell.id
                            }
                    }
                
                return Observable<String>.merge(selected)
            }
            .bind(onNext: { id in
                interactor.selected.accept(id)
            })
        
        state = cells
            .map { cells in
                MainGamesTableViewModelState.loaded(cells)
            }
    }
}

extension MainGamesTableViewModel: MainGamesTableViewModelProtocol {
    
}
