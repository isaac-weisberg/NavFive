import RxSwift
import UIKit
import NavFive

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {
    let window = UIWindow(frame: UIScreen.main.bounds)
    var subscription: Disposable!
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        window.makeKeyAndVisible()
        let navitroller = SequentialNavitroller()
        window.rootViewController = navitroller

        subscription = MainCoordinator
            .make(view: navitroller)
            .start
            .drive()
    }
}
