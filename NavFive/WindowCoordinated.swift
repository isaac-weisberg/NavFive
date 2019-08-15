import RxSwift
import RxCocoa
import UIKit

public class WindowCoordinated<NavigationState: WindowNavigationState>: UIWindow {
    typealias State = ViewState<NavigationState>
    
    let disposeBag = DisposeBag()
    
    let state = BehaviorRelay<State>(value: .uncoordinated)
    
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
        state
            .bind(onNext: {[unowned self] state in
                switch state {
                case .coordinated(let state):
                    let controller = state.asViewController
                    self.rootViewController = controller
                case .uncoordinated:
                    break
                }
            })
            .disposed(by: disposeBag)
        
        state
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
