//
//  Created by tonezone6 on 02.03.2021.
//

import LocalAuthentication

struct BiometricsService {
    
    let context: LAContext
    let policy: LAPolicy
    let reason = "Unlock using biometrics"
    
    init() {
        context = LAContext()
        policy = .deviceOwnerAuthenticationWithBiometrics
    }
    
    var isAvailable: Bool {
        var err: NSError?
        if context.canEvaluatePolicy(policy, error: &err) {
            return true
        }
        return false
    }
    
    func evaluatePolicy(completion: @escaping (Result<Bool, Error>) -> Void) {
        context.evaluatePolicy(policy, localizedReason: reason, reply: { success, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(true))
                }
            }
        })
    }
}
