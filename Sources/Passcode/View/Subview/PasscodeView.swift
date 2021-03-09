//
//  Created by tonezone6 on 02.03.2021.
//

import UIKit

protocol PasscodeViewDelegate: AnyObject {
    func tapped(number: Int)
    func tappedBiometrics()
    func tappedDelete()
}

final class PasscodeView: UIView {
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let biometricsButton = UIButton(type: .custom)
    let deleteButton = UIButton(type: .custom)
    private(set) var pinsView: PinsView!
    
    weak var delegate: PasscodeViewDelegate?
            
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        backgroundColor = background
        pinsView = PinsView(tint: tint)
        setupLabels()
        setupMainStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UI constants.

private extension PasscodeView {
    
    var spacing: CGFloat { 10 }
    var pinSize: CGFloat { 18 }
    var background: UIColor {
        UIColor(named: "background", in: Bundle.module, compatibleWith: nil)!
    }
    var tint: UIColor {
        UIColor(named: "darkText", in: Bundle.module, compatibleWith: nil)!
    }
    var fingerprint: UIImage {
        UIImage(named: "icon_fingerprint", in: Bundle.module, compatibleWith: nil)!
    }
    var fingerprintInsets: UIEdgeInsets {
        .init(top: 18, left: 18, bottom: 18, right: 18)
    }
    var deleteButtonTitle: String { "Delete" }
}

// MARK: Target actions.

private extension PasscodeView {
    
    @objc func digitButtonTapped(sender: PasscodeButton) {
        delegate?.tapped(number: sender.tag)
    }
    
    @objc func deleteButtonTapped(sender: UIButton) {
        delegate?.tappedDelete()
    }
    
    @objc func biometricsButtonTapped(sender: UIButton) {
        delegate?.tappedBiometrics()
    }
}

// MARK: View helpers.

extension PasscodeView {
    
    func setupLabels() {
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.textColor = tint
        titleLabel.textAlignment = .center
        
        descriptionLabel.font = .preferredFont(forTextStyle: .body)
        descriptionLabel.textColor = tint
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
    }
    
    func setupMainStack() {
        let vstack = VStack()
        
        vstack.addArrangedSubview(UIView())
        vstack.addArrangedSubview(titleLabel)
        vstack.addArrangedSubview(descriptionLabel)
        vstack.addArrangedSubview(pinsView)
        vstack.addArrangedSubview(keyboardStack)
        
        vstack.setCustomSpacing(16, after: titleLabel)
        vstack.setCustomSpacing(8, after: descriptionLabel)
        vstack.setCustomSpacing(24, after: pinsView)
        
        let constraints = [
            vstack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75),
            vstack.centerXAnchor.constraint(equalTo: centerXAnchor),
            vstack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            vstack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -32)
        ]
        addSubview(vstack)
        vstack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
    
    func createButton(with digit: Int) -> PasscodeButton {
        let button = PasscodeButton(digit: digit, background: background, tint: tint)
        button.addTarget(self, action: #selector(digitButtonTapped(sender:)), for: .touchUpInside)
        return button
    }
    
    var keyboardStack: VStack {
        let one   = createButton(with: 1)
        let two   = createButton(with: 2)
        let three = createButton(with: 3)
        let four  = createButton(with: 4)
        let five  = createButton(with: 5)
        let six   = createButton(with: 6)
        let seven = createButton(with: 7)
        let eight = createButton(with: 8)
        let nine  = createButton(with: 9)
        let zero  = createButton(with: 0)

        biometricsButton.setImage(fingerprint, for: .normal)
        biometricsButton.tintColor = tint
        biometricsButton.addTarget(self, action: #selector(biometricsButtonTapped(sender:)), for: .touchUpInside)
        biometricsButton.imageEdgeInsets = fingerprintInsets
        
        deleteButton.setTitle(deleteButtonTitle, for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped(sender:)), for: .touchUpInside)
        deleteButton.titleLabel?.font = .preferredFont(forTextStyle: .subheadline)
        deleteButton.setTitleColor(tint, for: .normal)
        
        let l1HStack = HStack(spacing: spacing, distribution: .fillEqually)
        l1HStack.addArrangedSubview(one)
        l1HStack.addArrangedSubview(two)
        l1HStack.addArrangedSubview(three)
        
        let l2HStack = HStack(spacing: spacing, distribution: .fillEqually)
        l2HStack.addArrangedSubview(four)
        l2HStack.addArrangedSubview(five)
        l2HStack.addArrangedSubview(six)
        
        let l3HStack = HStack(spacing: spacing, distribution: .fillEqually)
        l3HStack.addArrangedSubview(seven)
        l3HStack.addArrangedSubview(eight)
        l3HStack.addArrangedSubview(nine)
        
        let l4HStack = HStack(spacing: spacing, distribution: .fillEqually)
        l4HStack.addArrangedSubview(biometricsButton)
        l4HStack.addArrangedSubview(zero)
        l4HStack.addArrangedSubview(deleteButton)
        
        let vstack = VStack(spacing: spacing, distribution: .fillEqually)
        vstack.addArrangedSubview(l1HStack)
        vstack.addArrangedSubview(l2HStack)
        vstack.addArrangedSubview(l3HStack)
        vstack.addArrangedSubview(l4HStack)
        
        // Aspect ratios 1:1.
        NSLayoutConstraint.activate([
            one.heightAnchor.constraint(equalTo: one.widthAnchor),
            four.heightAnchor.constraint(equalTo: four.widthAnchor),
            seven.heightAnchor.constraint(equalTo: seven.widthAnchor),
            zero.heightAnchor.constraint(equalTo: zero.widthAnchor)
        ])
        
        return vstack
    }
}
