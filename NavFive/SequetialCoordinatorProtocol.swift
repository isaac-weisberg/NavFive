import UIKit
import RxSwift
import RxCocoa

protocol SequentialCoordinatorProtocol {
    var controllers: Driver<[UIViewController]> { get }
}

extension SequetialCoordinator: SequentialCoordinatorProtocol {
    public var controllers: Driver<[UIViewController]> {
        return stateRelay
            .asDriver()
            .flatMapLatest { state in
                state?.state.naviUnit.asViewControllers ?? .never()
            }
    }
}
