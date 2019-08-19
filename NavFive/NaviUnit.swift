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

public protocol NaviUnitConvertible {
    var naviUnit: NaviUnit { get }
}

public protocol NaviUnitArrayConvertible {
    var naviUnits: [NaviUnit] { get }
}
