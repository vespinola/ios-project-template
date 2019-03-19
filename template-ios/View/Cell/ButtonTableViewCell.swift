//
//  ButtonTableViewCell.swift
//  
//
//  Created by Vladimir Espinola on 1/3/19.
//  Copyright © 2019 vel. All rights reserved.
//

import UIKit

class ButtonTableViewCell: CustomTableViewCell {
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    
    var padding: UIEdgeInsets! {
        didSet {
            bottomConstraint.constant = padding.bottom
            topConstraint.constant = padding.top
            leadingConstraint.constant = padding.left
            trailingConstraint.constant = padding.right
        }
    }
    
    var onTap: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        button.setupDefaultStyle()
    }
    
    func configure(title: String, onTap: @escaping () -> Void) {
        self.button.setTitle(title, for: .normal)
        self.onTap = onTap
    }

    @IBAction func buttonOnTap(_ sender: Any) {
        onTap?()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        onTap = nil
        button.setupDefaultStyle()
    }
}

extension ButtonTableViewCell: TableViewProtocol {
    static func register(in tableView: UITableView) {
        tableView.register(UINib(resource: R.nib.buttonTableViewCell), forCellReuseIdentifier: R.reuseIdentifier.buttonTableViewCellReuseID.identifier)
    }
    
    static func instante(from tableView: UITableView, at indexPath: IndexPath) -> ButtonTableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.buttonTableViewCellReuseID, for: indexPath)!
    }
}
