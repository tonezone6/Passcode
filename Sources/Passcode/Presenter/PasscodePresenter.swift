//
//  Created by tonezone6 on 02.03.2021.
//

protocol PasscodeInputProtocol {
    func viewDidLoad()
    func enter(number: Int)
    func delete()
    func useBiometrics()
}

protocol PasscodeOutputProtocol: AnyObject {
    func send(_ output: Output)
}

class PasscodePresenter {
    weak var output: PasscodeOutputProtocol?

    let storage: PasscodeStorageProtocol
    let biometrics = BiometricsService()

    let mode: Mode
    let title: String
    let description: String
            
    // Pin vars.
    private var isFirstCreationStep = true
    private var pass = ""         // user input
    private var reservedPass = "" // confirmation pin
      
    init(secureStorage: PasscodeStorageProtocol) {
        self.storage = secureStorage

        mode = storage.passcode == nil ? .create : .validate
        title = "Passcode"
        description = mode.description
    }
}

extension PasscodePresenter: PasscodeInputProtocol {

    func viewDidLoad() {
        switch mode {
        case .validate:
            output?.send(.biometrics(biometrics.isAvailable))
        case .create:
            output?.send(.biometrics(false))
        }
    }
    
    func enter(number: Int) {
        let count = 4
        
        if pass.count < count {
            pass.append("\(number)")
            output?.send(.highlight)
        }
        
        if pass.count == count {
            switch mode {
            case .create:   createPin()
            case .validate: validatePin()
            }
        }
    }
    
    func delete() {
        guard pass.count > 0 else { return }
        pass.removeLast()
    }
    
    func useBiometrics() {
        biometrics.evaluatePolicy { [weak self] result in
            switch result {
            case .failure(let error):
                let reason = error.localizedDescription
                self?.output?.send(.biometricsFailed(reason))
            case .success:
                self?.output?.send(.dismiss)
            }
        }
    }
}

// MARK: Helpers.

private extension PasscodePresenter {
    
    func createPin() {
        if isFirstCreationStep {
            isFirstCreationStep = false
            reservedPass = pass
            pass = ""
            output?.send(.confirmPasscode("Confirm your passcode"))
        } else {
            confirmPin()
        }
    }
    
    func confirmPin() {
        if pass == reservedPass {
            storage.save(passcode: pass)
            output?.send(.dismiss)
        } else {
            pass = ""
            output?.send(.missmatch)
        }
    }
    
    func validatePin() {
        if let stored = storage.passcode, stored == pass {
            output?.send(.dismiss)
        } else {
            pass = ""
            output?.send(.missmatch)
        }
    }
}
