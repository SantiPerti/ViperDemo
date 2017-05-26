import Foundation
import UIKit

extension UIViewController {
    static func initFromStoryboard<T>(name: String, identifier: String) -> T {
        guard let vc = UIStoryboard(name: name, bundle: nil)
            .instantiateViewController(withIdentifier: identifier) as? T else {
                fatalError("\(identifier) could not be loaded from \(name) as \(T.self)")
        }
        
        return vc
    }
}
