import Foundation
import UIKit

/// Dependencias especificas de plataforma (Views y Wireframes).
public class DependenciesiOS: SharedDependencies {
    private let navigationController: UINavigationController
    private let window: UIWindow
    
    init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
        
        window.rootViewController = navigationController
    }
    
    // Root 
    
    func presentRootView() {
        let wireframe = loginWireframe(navigationController: navigationController)
        let vc = loginViewController(wireframe: wireframe)
        
        navigationController.viewControllers = [vc]
        
    }
    
    // Views
    
    func loginViewController(wireframe: LoginWireframe) -> LoginViewController {
        let vc = LoginViewController.initFromStoryboard()
        vc.presenter = super.loginPresenter(view: vc, wireframe: wireframe)
        return vc
    }
    
    // Wireframe
    
    func loginWireframe(navigationController: UINavigationController) -> LoginWireframe {
        return LoginWireframeiOS(navigationController: navigationController, dependencies: self)
    }
}
