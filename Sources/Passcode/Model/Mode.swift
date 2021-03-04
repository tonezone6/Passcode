//
//  Created by tonezone6 on 02.03.2021.
//

enum Mode {
    case create
    case validate
    
    var description: String {
        switch self {
        case .create:
            return "Create a passcode"
        case .validate:
            return "Enter your passcode"
        }
    }
}
