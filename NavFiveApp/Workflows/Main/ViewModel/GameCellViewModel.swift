protocol GameCellViewModelProtocol {
    var title: String { get }
}

struct GameCellViewModel {
    let title: String
    
    init(title: String) {
        self.title = title
    }
}

extension GameCellViewModel: GameCellViewModelProtocol {
    
}
