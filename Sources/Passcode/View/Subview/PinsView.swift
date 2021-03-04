//
//  File.swift
//  
//
//  Created by Alex Stratu on 04.03.2021.
//

import UIKit

class PinsView: UIView {
    
    let pin1: PinItemView!
    let pin2: PinItemView!
    let pin3: PinItemView!
    let pin4: PinItemView!
    
    var allPins: [PinItemView] {
        [pin1, pin2, pin3, pin4]
    }
    
    let pinSize: CGFloat = 18
    
    init(tint: UIColor = .lightGray) {
        pin1 = PinItemView(tint: tint)
        pin2 = PinItemView(tint: tint)
        pin3 = PinItemView(tint: tint)
        pin4 = PinItemView(tint: tint)
        super.init(frame: .zero)
        
        setupAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func clear() {
        allPins.forEach { $0.check(false) }
    }
    
    func shake() {
        clear()
        startAnimation()
    }
    
    func highlightNext() {
        let unchecked = allPins.filter { $0.checked == false }
        unchecked.first?.check(true)
    }
    
    func unhighlightLast() {
        let checked = allPins.filter { $0.checked }
        let last = checked.last
        last?.check(false)
    }
}

private extension PinsView {
    
    func startAnimation() {
        let animationKeyPath = "transform.translation.x"
        let shakeAnimation = "shake"
        let duration = 0.4
        let animation = CAKeyframeAnimation(keyPath: animationKeyPath)
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = duration
        animation.values = [-15, 15, -15, 15, -10, 10, -5, 5, 0]
        layer.add(animation, forKey: shakeAnimation)
    }
    
    func setupAutolayout() {
        let pinsStack = HStack(spacing: 8, distribution: .fillEqually)
        pinsStack.addArrangedSubview(pin1)
        pinsStack.addArrangedSubview(pin2)
        pinsStack.addArrangedSubview(pin3)
        pinsStack.addArrangedSubview(pin4)
        
        let constraints = [
            pin1.widthAnchor.constraint(equalToConstant: pinSize),
            pin1.heightAnchor.constraint(equalToConstant: pinSize),
            pinsStack.topAnchor.constraint(equalTo: topAnchor),
            pinsStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            pinsStack.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
        
        addSubview(pinsStack)
        pinsStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
}
