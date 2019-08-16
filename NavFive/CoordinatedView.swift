import RxSwift
import RxCocoa

public protocol CoordinatedView {
    associatedtype NavigationState
    
    var coordinationState: BehaviorRelay<ViewState<NavigationState>> { get }
}

internal extension CoordinatedView {
    
}
