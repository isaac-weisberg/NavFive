import UIKit

public protocol NaviUnit {
    var asViewController: UIViewController { get }
}

extension UIViewController: NaviUnit {
    public var asViewController: UIViewController {
        return self
    }
}

extension NavitrollerCoordinator: NaviUnit {
    public var asViewController: UIViewController {
        return self.view
    }
}

public protocol NaviUnitConvertible: ViewMetaState {
    var naviUnit: NaviUnit { get }
}
