import Foundation
import ReactiveSwift
import ReactiveCocoa

protocol UserController {
    func login(username: String, password: String) -> SignalProducer<Void, LoginError>
}

class FakeUserController: UserController {
    private let queue = QueueScheduler(qos: .userInitiated, name: "jmpg93.viperRac.userController")
    
    func login(username: String, password: String) -> SignalProducer<Void, LoginError> {
        return SignalProducer { observer, _ in
            sleep(3)
            if Bool.random {
                observer.send(error: .networkError)
            } else {
                observer.send(value: ())
                observer.sendCompleted()
            }
        }.start(on: queue)
    }
}

class NetworkUserController: UserController {
    func login(username: String, password: String) -> SignalProducer<Void, LoginError> {
        return SignalProducer { observer, _ in
            observer.sendCompleted()
        }
    }
}

extension Bool {
    static var random: Bool {
        return arc4random_uniform(2) == 0
    }
}

