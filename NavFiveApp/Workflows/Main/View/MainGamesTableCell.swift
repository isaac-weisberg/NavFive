import UIKit

class MainGamesTableCell: UITableViewCell {
    @IBOutlet var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    func apply(viewModel: GameCellViewModelProtocol) {
        label.text = viewModel.title
    }
}
