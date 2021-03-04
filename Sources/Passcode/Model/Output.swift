//
//  Created by tonezone6 on 02.03.2021.
//

enum Output {
    case confirmPasscode(String)
    case highlight
    case missmatch
    case dismiss
    case biometrics(Bool)
    case biometricsFailed(String)
}
