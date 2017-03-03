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
            .map(isValidPassword)
        
        validUser
            .combineLatest(with: validPassword)
            .observe(on: UIScheduler())
            .map({ $0 && $1 })
            .observeValues { isEnabled in
                self.loginButton.isEnabled = isEnabled
            }
        
        loginButton
            .reactive
            .controlEvents(.touchUpInside)
            .observeValues(login)
        
        
    }

    private let queue = QueueScheduler(qos: .userInitiated, name: "jmpg93.viperRac")
    
    private func login(button: UIButton) {
        guard let username = usernameTextField.text, let password = passwordTextField.text else {
            return
        }
        
        print("Starting login...")
        
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
    
    private func isValidPassword(pass: String) -> Bool {
        return pass.characters.count > 3
    }
    
    private func isValidEmail(email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        
        return emailPredicate.evaluate(with: email)
    }
}
