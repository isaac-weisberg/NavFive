import UIKit

extension UITableView {
    func registerCell<Cell: UITableViewCell>(cell: Cell.Type) {
        let nibName = "\(Cell.self)"
        let nib = UINib(nibName: nibName, bundle: nil)
        let identifier = nibName
        register(nib, forCellReuseIdentifier: identifier)
    }
    
    func dequeueCell<Cell: UITableViewCell>(at indexPath: IndexPath) -> Cell {
        let identifier = "\(Cell.self)"
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! Cell
    }
}
