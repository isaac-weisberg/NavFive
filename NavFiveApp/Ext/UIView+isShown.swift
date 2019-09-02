import UIKit
import RxSwift
import RxCocoa

extension UIView {
    var isShown: Bool {
        get {
            return !isHidden
        }
        set {
            isHidden = !newValue
        }
    }
}

extension Reactive where Base: UIView {
    var isShown: Binder<Bool> {
        return Binder(base) { shelf, value in
            shelf.isShown = value
        }
    }
}
