import UIKit
import RxSwift
import RxCocoa

public class SequentialWindow: UIWindow, SequentialViewProtocol {
    public let naviSposeBag = DisposeBag()
    
    public let state = BehaviorRelay<[UIViewController]>(value: [])
    
    public let expressedAsViewController: Driver<UIViewController>
    
    public override init(frame: CGRect) {
        expressedAsViewController = state
            .asDriver()
            .flatMapLatest { controllers in
                if let last = controllers.last {
                    return .just(last)
                }
                return .never()
            }
        
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        expressedAsViewController = state
            .asDriver()
            .flatMapLatest { controllers in
                if let last = controllers.last {
                    return .just(last)
                }
                return .never()
            }
        
        super.init(coder: aDecoder)
        setup()
    }
}

private extension SequentialWindow {
    func setup() {
        state
            .asDriver()
            .map { controllers in
                controllers.last
            }
            .drive(onNext: {[unowned self] controller in
                self.rootViewController = controller
            })
            .disposed(by: naviSposeBag)
    }
}
