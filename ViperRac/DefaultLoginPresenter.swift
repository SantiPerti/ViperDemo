import Foundation
import ReactiveSwift

class DefaultLoginPresenter: LoginPresenter {
    private weak var view: LoginView?
    private let wireframe: LoginWireframe
    private let userController: UserController
    
    init(view: LoginView, wireframe: LoginWireframe, userController: UserController) {
        self.view = view
        self.wireframe = wireframe
        self.userController = userController
    }
    
    func login(username: String, password: String) {
        userController
            .login(username: username, password: password)
            .observe(on: UIScheduler())
            .startWithResult { result in
                switch result {
                case .success:
                    print("Login ok")
                    self.presentMainView()
                case .failure:
                    print("Login error")
                    self.view?.presentAlert(title: "Error")
                }
        }
    }
    
    func isValidPassword(pass: String) -> Bool {
        return pass.characters.count > 3
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        
        return emailPredicate.evaluate(with: email)
    }
    
    func presentMainView() {
        wireframe.presentMainView()
    }
}
