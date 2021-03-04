//
//  Created by tonezone6 on 02.03.2021.
//

import UIKit

extension UIApplication {
    
    var rootViewController: UIViewController? {
        keyWindow?.rootViewController
    }
}

public struct Passcode {
    
    public static func present(using storage: PasscodeStorageProtocol) {
        let presenter = PasscodePresenter(secureStorage: storage)
        let controller = PasscodeViewController(presenter: presenter)
        controller.modalPresentationStyle = .fullScreen
        
        UIApplication.shared.rootViewController?
            .present(controller, animated: true, completion: nil)
    }
}
