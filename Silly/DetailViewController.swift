import RxSwift
import RxCocoa
import UIKit

class DetailViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        
        let label = UILabel(frame: .zero)
        label.text = "This is detail"
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
