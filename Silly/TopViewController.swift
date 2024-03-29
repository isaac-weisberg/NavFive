import RxSwift
import RxCocoa
import UIKit

class TopViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let proceedRequested: Observable<Void>
    
    init() {
        let button = UIButton(type: .system)
        
        proceedRequested = button.rx.tap
            .asObservable()
        
        super.init(nibName: nil, bundle: nil)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Proceed", for: .normal)
        
        view.backgroundColor = .white
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
