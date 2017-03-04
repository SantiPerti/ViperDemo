import Foundation
import UIKit

class LoginWireframeiOS: LoginWireframe {
    let navigationController: UINavigationController
    let dependencies: DependenciesiOS
    
    init(navigationController: UINavigationController, dependencies: DependenciesiOS) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func presentMainView() {
        let wireframe = dependencies.loginWireframe(navigationController: navigationController)
        let vc = dependencies.loginViewController(wireframe: wireframe)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
