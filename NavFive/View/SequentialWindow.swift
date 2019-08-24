import UIKit
import RxSwift
import RxCocoa

public class SequentialWindow: UIWindow, SequentialViewProtocol {
    public let naviSposeBag = DisposeBag()
    
    public let state = PublishRelay<[UIViewController]>()
    
    public var expressedAsViewController: Driver<UIViewController> {
        return state
            .asDriver { _ in .never() }
            .flatMapLatest { controllers in
                if let last = controllers.last {
                    return .just(last)
                }
                return .never()
            }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

private extension SequentialWindow {
    func setup() {
        state
            .map { controllers in
                controllers.last
            }
            .bind(onNext: {[unowned self] controller in
                self.rootViewController = controller
            })
            .disposed(by: naviSposeBag)
    }
}
