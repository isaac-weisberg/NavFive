import UIKit
import RxSwift
import RxCocoa

public enum SequentialNaviUnit {
    case one(UIViewController)
    case child(SequentialCoordinatorProtocol)
    case many([SequentialNaviUnit])
}

public protocol NaviUnitConvertible {
    var naviUnit: SequentialNaviUnit { get }
}

extension SequentialNaviUnit {
    var asViewControllers: Driver<[UIViewController]> {
        switch self {
        case .one(let controller):
            return .just([controller])
        case .child(let coordinator):
            return coordinator.controllers
        case .many(let units):
            let drivers = units.map { unit in
                unit.asViewControllers
            }
            return Driver.zip(drivers) { arrays -> [UIViewController] in
                Array(arrays.joined())
            }
        }
    }
}
