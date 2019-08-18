import RxSwift
import RxCocoa

public protocol ViewMetaState {
    
}

protocol CoordinatedView {
    associatedtype State: ViewMetaState
    
    var coordinationState: BehaviorRelay<State?> { get }
}
