import RxSwift
import RxCocoa
import UIKit

public class WindowCoordinated: UIWindow {
    public let naviSposeBag = DisposeBag()
    
    let coordinationState = BehaviorRelay<NaviUnitConvertible?>(value: nil)
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

private extension WindowCoordinated {
    func setup() {
        coordinationState
            .bind(onNext: {[unowned self] state in
                if let state = state {
                    let controller = state.naviUnit.asViewController
                    self.rootViewController = controller
                }
            })
            .disposed(by: naviSposeBag)
        
        coordinationState
            .distinctUntilChanged { prev, next in
                switch (prev, next) {
                case (.none, .none), (.some, .some):
                    return true
                case (.none, .some), (.some, .none):
                    return false
                }
            }
            .bind(onNext: {[unowned self] state in
                switch state {
                case .some:
                    self.makeKeyAndVisible()
                case .none:
                    break
                }
            })
            .disposed(by: naviSposeBag)
    }
}
