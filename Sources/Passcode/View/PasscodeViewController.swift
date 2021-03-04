//
//  Created by tonezone6 on 02.03.2021.
//

import UIKit

class PasscodeViewController: UIViewController {

    let passcodeView = PasscodeView()
    let presenter: PasscodePresenter
    
    init(presenter: PasscodePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        passcodeView.delegate = self
        view = passcodeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.output = self
        presenter.viewDidLoad()
        
        passcodeView.titleLabel.text = presenter.title
        passcodeView.descriptionLabel.text = presenter.description
    }
}

extension PasscodeViewController: PasscodeViewDelegate {
    
    func tapped(number: Int) {
        presenter.enter(number: number)
    }
    
    func tappedDelete() {
        presenter.delete()
        passcodeView.pinsView.unhighlightLast()
    }
    
    func tappedBiometrics() {
        presenter.useBiometrics()
    }
}

extension PasscodeViewController: PasscodeOutputProtocol {
    
    func send(_ output: Output) {
        switch output {
        case .highlight:
            passcodeView.pinsView.highlightNext()
        
        case .missmatch:
            passcodeView.pinsView.shake()
        
        case .confirmPasscode(let message):
            passcodeView.pinsView.clear()
            passcodeView.descriptionLabel.text = message
        
        case .biometrics(let visible):
            biometrics(hidden: !visible)
        
        case .biometricsFailed(let reason):
            showBiometrics(alert: reason)
        
        case .dismiss:
            dismiss(animated: true, completion: nil)
        }
    }
}

private extension PasscodeViewController {
    
    func biometrics(hidden: Bool) {
        passcodeView.biometricsButton.alpha = hidden ? 0 : 1
        passcodeView.biometricsButton.isUserInteractionEnabled = !hidden
    }
    
    func showBiometrics(alert: String) {
        let alert = UIAlertController(title: "Biometrics", message: alert, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}
