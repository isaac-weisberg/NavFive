import RxSwift
import RxCocoa

protocol GameCellViewModelProtocol {
    var title: String { get }
}

struct GameCellViewModel {
    let title: String
    let id: String
    
    let tap = PublishRelay<Void>()
    
    init(model: GameModel) {
        self.title = model.title
        self.id = model.id
    }
}

extension GameCellViewModel: GameCellViewModelProtocol {
    
}
