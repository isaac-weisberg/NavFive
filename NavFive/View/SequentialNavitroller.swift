import UIKit
import RxSwift
import RxCocoa

public class SequentialNavitroller: UINavigationController, SequentialViewProtocol {
    public var expressedAsViewController: Driver<UIViewController> {
        return .just(self)
    }
    
    public let naviSposeBag = DisposeBag()
    
    public let state = BehaviorRelay<[UIViewController]>(value: [])
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
        setup()
    }
    
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setup()
    }
}

private extension SequentialNavitroller {
    func setup() {
        state
            .bind(onNext: {[unowned self] controllers in
                self.setViewControllers(controllers, animated: true)
            })
            .disposed(by: naviSposeBag)
    }
}
