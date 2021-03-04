//
//  Created by tonezone6 on 02.03.2021.
//

import UIKit

class PasscodeButton: UIButton {
    
    let tint: UIColor
    
    init(digit: Int, background: UIColor = .white, tint: UIColor = .gray) {
        self.tint = tint
        super.init(frame: .zero)

        setTitle("\(digit)", for: .normal)
        titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        setTitleColor(tint, for: .normal)
        backgroundColor = background
        tag = digit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.borderColor = tint.withAlphaComponent(0.1).cgColor
        layer.borderWidth = 2
        layer.cornerRadius = bounds.height/2
    }
}
