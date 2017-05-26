import Foundation
import ReactiveSwift

protocol LoginPresenter {
    func login(username: String, password: String)
    
    func isValidEmail(email: String) -> Bool
    func isValidPassword(pass: String) -> Bool
}
