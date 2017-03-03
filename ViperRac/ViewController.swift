import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

enum LoginError: Error {
    case invalidEmail
    case networkError
}

class ViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!

    private var userController = UserController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginButton.isEnabled = false
        
        let validUser = usernameTextField
            .reactive
            .continuousTextValues
            .skipNil()
            .map(isValidEmail)
        
        let validPassword = passwordTextField
            .reactive
            .continuousTextValues
            .skipNil()
            .map(isValidUsername)
        
        loginButton
            .reactive
            .controlEvents(.touchUpInside)
            .observe(on: UIScheduler())
            .observeValues(login)
        
    }

    private let queue = QueueScheduler(qos: .userInitiated, name: "jmpg93.viperRac")
    
    private func login(button: UIButton) {
        guard let username = usernameTextField.text, let password = passwordTextField.text else {
            return
        }
        
        userController
            .login(username: username, password: password)
            .start(on: queue)
            .observe(on: UIScheduler())
            .start { event in
                switch event {
                case let .failed(error):
                    print("Login error: \(error)")
                case .completed:
                    print("Login did fine!")
                case .interrupted:
                    print("Interrupted")
                case let .value(value):
                    print("Value: \(value)")
                }
            }
        
    }
    
    private func isValidUsername(user: String) -> Bool {
        return user.characters.count > 3
    }
    
    private func isValidEmail(email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
}

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

