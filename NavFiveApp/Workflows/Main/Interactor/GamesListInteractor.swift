import RxSwift
import RxCocoa

protocol GamesListInteractorProtocol {
    var games: Driver<[GameModel]> { get }
    
    var selected: PublishRelay<String> { get }
}

struct GamesListInteractor {
    let games: Driver<[GameModel]>
    let selected = PublishRelay<String>()
    
    init() {
        games = .just(
            [
                "Battlefront II",
                "Knack 2",
                "Petscop",
                "Minecraft"
            ].map(GameModel.init(title:))
        )
    }
}

extension GamesListInteractor: GamesListInteractorProtocol {
    
}
