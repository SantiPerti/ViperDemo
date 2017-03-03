import Foundation
import ReactiveSwift
import ReactiveCocoa

class UserController {
    func login(username: String, password: String) -> SignalProducer<Void, LoginError> {
        return SignalProducer { observer, _ in
            sleep(3)
            if Float(arc4random()) / Float(UINT32_MAX) == 1 {
                observer.send(error: LoginError.networkError)
            } else {
                observer.sendCompleted()
            }
        }
    }
}
