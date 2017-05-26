import Foundation

/// Dependencias que se podrían compartir entre diferentes plataformas (Controladores y Presenters). 
public class SharedDependencies {
    
    // Controllers
    
    lazy var userController: UserController = {
       return FakeUserController()
    }()
    
    // Presetners
    
    func loginPresenter(view: LoginView, wireframe: LoginWireframe) -> LoginPresenter {
        return DefaultLoginPresenter(view: view,
                                     wireframe: wireframe,
                                     userController: userController)
    }
}
