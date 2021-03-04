//
//  Created by tonezone6 on 02.03.2021.
//

import UIKit

class PinItemView: UIView {
    
    private(set) var checked = false
    private(set) var tint: UIColor
    
    init(tint: UIColor = .lightGray) {
        self.tint = tint
        super.init(frame: .zero)
        
        check(false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height/2
    }
}

extension PinItemView {
    
    func check(_ bool: Bool) {
        self.checked = bool
        let color = tint.withAlphaComponent(0.5)
        
        if checked {
            layer.borderWidth = 0
            backgroundColor = color
        } else {
            layer.borderWidth = 2
            layer.borderColor = color.cgColor
            backgroundColor = .clear
        }
    }
}
