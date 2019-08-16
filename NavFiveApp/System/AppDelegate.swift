import RxSwift
import NavFive
import UIKit

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {
    var mainCoordinator: MainCoordinator.Instance!
    var mainSubscription: Disposable!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navController = MainCoordinator.Instance.View(nibName: nil, bundle: nil)
        window.rootViewController = navController
        window.makeKeyAndVisible()
        
        mainCoordinator = MainCoordinator.make(view: navController)
        
        mainSubscription = mainCoordinator.state
            .drive()
        
        return true
    }
}
