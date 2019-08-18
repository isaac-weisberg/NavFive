import RxSwift
import RxCocoa
import UIKit

public class NavitrollerCoordinated: UINavigationController, CoordinatedView {
    public let naviSposeBag = DisposeBag()
    
    public let coordinationState = BehaviorRelay<ArrayControllerConvertible?>(value: nil)
    
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

private extension NavitrollerCoordinated {
    func setup() {
        coordinationState
            .bind(onNext: {[unowned self] state in
                let controllers = state?.asViewControllers ?? []
                self.setViewControllers(controllers, animated: true)
            })
            .disposed(by: naviSposeBag)
    }
}
