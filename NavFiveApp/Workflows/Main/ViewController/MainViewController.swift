import UIKit

class MainViewController: UIViewController {
    var viewModel: MainViewModel!
    
    @IBOutlet var gamesTableView: MainGamesTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gamesTableView.apply(viewModel: viewModel.gameListViewModel)
    }
}

extension MainViewController {
    static func make(viewModel: MainViewModel) -> MainViewController {
        let controller = MainViewController(nibName: "\(self)", bundle: .main)
        controller.viewModel = viewModel
        return controller
    }
}
