import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var dependencies: DependenciesiOS!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        let navigationController = UINavigationController()
        
        dependencies = DependenciesiOS(navigationController: navigationController, window: window!)
        dependencies.presentRootView()
        
        return true
    }
}

