import RxSwift
import NavFive
import UIKit

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {
    var mainCoordinator: AppCoordinator.Instance!
    var mainSubscription: Disposable!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let window = AppCoordinator.Instance.View(frame: UIScreen.main.bounds)
        mainCoordinator = AppCoordinator.make(view: window)
        mainSubscription = mainCoordinator
            .state
            .drive()
        
        return true
    }
}
