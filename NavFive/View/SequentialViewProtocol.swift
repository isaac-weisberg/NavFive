import UIKit
import RxSwift
import RxCocoa

public protocol SequentialViewProtocol {
    var naviSposeBag: DisposeBag { get }
    
    var state: BehaviorRelay<[UIViewController]> { get }
}
