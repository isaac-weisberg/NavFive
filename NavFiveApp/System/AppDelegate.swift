import NavFive
import UIKit

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {
    var mainCoordinator: MainCoordinator.Instance!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        mainCoordinator = MainCoordinator.make(window: window)
        
        return true
    }
}
