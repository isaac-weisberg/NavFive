import UIKit
import RxSwift
import RxCocoa

public protocol SequentialViewProtocol {
    var naviSposeBag: DisposeBag { get }
    
    var state: PublishRelay<[UIViewController]> { get }
    
    var expressedAsViewController: Driver<UIViewController> { get }
}
