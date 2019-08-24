import UIKit
import RxSwift
import RxCocoa

public class SequentialNavitroller: UINavigationController, SequentialViewProtocol {
    public let naviSposeBag = DisposeBag()
    
    public let state = PublishRelay<[UIViewController]>()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public var expressedAsViewController: Driver<UIViewController> {
        return .just(self)
    }
}

private extension SequentialNavitroller {
    func setup() {
        state
            .bind(onNext: {[unowned self] controllers in
                self.setViewControllers(controllers, animated: false)
            })
            .disposed(by: naviSposeBag)
    }
}
