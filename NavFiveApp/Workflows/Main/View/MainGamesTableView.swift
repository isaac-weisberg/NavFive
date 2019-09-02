import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MainGamesTableView: XibModularView {
    typealias Section = SectionModel<Void, GameCellViewModelProtocol>
    typealias DataSource = RxTableViewSectionedReloadDataSource<Section>
    
    var disposeBag: DisposeBag!
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var loadingView: LoadingView!
    
    let dataSource = DataSource(configureCell: { ds, tv, indexPath, item in
        let cell: MainGamesTableCell = tv.dequeueCell(at: indexPath)
        cell.apply(viewModel: item)
        return cell
    })
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func apply(viewModel: MainGamesTableViewModelProtocol) {
        disposeBag = DisposeBag()
        
        viewModel.state
            .map { state in
                switch state {
                case .loaded:
                    return false
                }
            }
            .drive(loadingView.rx.isShown)
            .disposed(by: disposeBag)
        
        viewModel.state
            .flatMapLatest { state -> Driver<[GameCellViewModelProtocol]> in
                switch state {
                case .loaded(let items):
                    return .just(items)
                }
            }
            .map { items in
                [ Section(model: (), items: items) ]
            }
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

private extension MainGamesTableView {
    func setup() {
        tableView.separatorStyle = .none
        tableView.registerCell(cell: MainGamesTableCell.self)
    }
}
