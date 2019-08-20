import UIKit

class MainViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .yellow
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.view = UIView()
        print("INIT coder")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.view = UIView()
        print("INIT reg")
    }
    
    deinit {
        print("DEINIT")
    }
}
