import RxSwift
import NavFive
import UIKit

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {
    var mainSubscription: Disposable!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let window = SequentialWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        let mainCoordinator = AppCoordinator.make(view: window)
        mainSubscription = mainCoordinator
            .start
            .drive()
        
        return true
    }
}
