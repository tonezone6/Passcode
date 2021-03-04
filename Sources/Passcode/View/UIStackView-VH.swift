//
//  Created by tonezone6 on 02.03.2021.
//

import UIKit

class VStack: UIStackView {
    
    init(spacing: CGFloat = 0, distribution: UIStackView.Distribution = .fill) {
        super.init(frame: .zero)
        self.spacing = spacing
        self.distribution = distribution
        self.alignment = .fill
        self.axis = .vertical
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HStack: UIStackView {
    
    init(spacing: CGFloat = 0, distribution: UIStackView.Distribution = .fill) {
        super.init(frame: .zero)
        self.spacing = spacing
        self.distribution = distribution
        self.alignment = .fill
        self.axis = .horizontal
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
