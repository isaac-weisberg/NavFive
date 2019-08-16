import RxSwift
import RxCocoa
import UIKit

public class WindowCoordinated<NavigationState: WindowNavigationState>: UIWindow, CoordinatedView {
    typealias State = ViewState<NavigationState>
    
    let disposeBag = DisposeBag()
    
    public let coordinationState = BehaviorRelay<State>(value: .uncoordinated)
    
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
                if let state = state.asOptional {
                    let controller = state.asViewController
                    self.rootViewController = controller
                }
            })
            .disposed(by: disposeBag)
        
        coordinationState
            .distinctUntilChanged { prev, next in
                switch (prev, next) {
                case (.uncoordinated, .uncoordinated), (.coordinated, .coordinated):
                    return true
                case (.coordinated, .uncoordinated), (.uncoordinated, .coordinated):
                    return true
                }
            }
            .bind(onNext: {[unowned self] state in
                switch state {
                case .coordinated:
                    self.makeKeyAndVisible()
                case .uncoordinated:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
}
