struct MainViewModel {
    init(interactor: GamesListInteractorProtocol) {
        gameListViewModel = MainGamesTableViewModel(interactor: interactor)
    }
    
    let gameListViewModel: MainGamesTableViewModelProtocol
}
