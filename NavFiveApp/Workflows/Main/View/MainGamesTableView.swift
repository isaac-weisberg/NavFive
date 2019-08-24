import UIKit
import RxSwift
import RxCocoa

class MainGamesTableView: XibModularView {
    let permaBag = DisposeBag()
    var disposeBag: DisposeBag!
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var loadingView: LoadingView!
    
    let dataset = BehaviorRelay<[GameCellViewModelProtocol]>(value: [])
    
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
            .flatMapLatest { state -> Driver<[GameCellViewModelProtocol]> in
                switch state {
                case .loaded(let items):
                    return .just(items)
                }
            }
            .drive(dataset)
            .disposed(by: disposeBag)
    }
}

private extension MainGamesTableView {
    func setup() {
        tableView.separatorStyle = .none
        tableView.dataSource = self
        
        tableView.registerCell(cell: MainGamesTableCell.self)
        
        dataset
            .asDriver()
            .drive(onNext: {[unowned self] cells in
                self.tableView.reloadData()
            })
            .disposed(by: permaBag)
    }
}

extension MainGamesTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataset.value[indexPath.row]
        let cell: MainGamesTableCell = tableView.dequeueCell(at: indexPath)
        cell.apply(viewModel: item)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataset.value.count
    }
}
