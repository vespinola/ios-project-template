//
//  BRTableViewCell.swift
//
//
//  Created by Vladimir Espinola on 1/31/19.
//  Copyright © 2019 vel. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    var isLast: Bool? {
        didSet {
            layoutSubviews()
        }
    }
    
    var isFirst: Bool? {
        didSet {
            layoutSubviews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let isFirst = isFirst, let isLast = isLast, isFirst, isLast {
            round(corners:.allCorners, radius: Metrics.cornerRadius)
        } else if let isFirst = isFirst, isFirst {
            round(corners: [.topLeft, .topRight], radius: isFirst ? Metrics.cornerRadius : CGFloat.leastNormalMagnitude)
        } else if let isLast = self.isLast, isLast {
            round(corners: [.bottomLeft, .bottomRight], radius: isLast ? Metrics.cornerRadius : CGFloat.leastNormalMagnitude)
            
        } else {
            round(corners: .allCorners, radius: CGFloat.leastNormalMagnitude)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        layer.mask = nil
    }
}
