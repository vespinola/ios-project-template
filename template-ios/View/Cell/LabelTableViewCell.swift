//
//  LabelTableViewCell.swift
//  
//
//  Created by Vladimir Espinola on 1/3/19.
//  Copyright © 2019 vel. All rights reserved.
//

import UIKit

class LabelTableViewCell: CustomTableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    var padding: UIEdgeInsets! {
        didSet {
            bottomConstraint.constant = padding.bottom
            topConstraint.constant = padding.top
            leadingConstraint.constant = padding.left
            trailingConstraint.constant = padding.right
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        titleLabel.font = .avenirRoman16
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textColor = .br_black
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        contentView.round(corners: .allCorners, radius: .leastNormalMagnitude)
    }
}

extension LabelTableViewCell: TableViewProtocol {
    static func register(in tableView: UITableView) {
        tableView.register(UINib(resource: R.nib.labelTableViewCell), forCellReuseIdentifier: R.reuseIdentifier.labelTableViewCellReuseID.identifier)
    }
    
    static func instante(from tableView: UITableView, at indexPath: IndexPath) -> LabelTableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.labelTableViewCellReuseID, for: indexPath)!
    }
}
