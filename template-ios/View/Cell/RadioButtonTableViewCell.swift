//
//  RadioButtonTableViewCell.swift
//  
//
//  Created by Vladimir Espinola on 2/11/19.
//  Copyright © 2019 vel. All rights reserved.
//

import UIKit

protocol RadioButtonTableViewCellDelegate: NSObjectProtocol {
    func didToggleRadioButton(_ indexPath: IndexPath)
}

class RadioButtonTableViewCell: UITableViewCell {
    @IBOutlet weak var radioButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    var insets: UIEdgeInsets! {
        didSet {
            topConstraint.constant = insets.top
            bottomConstraint.constant = insets.bottom
            leadingConstraint.constant = insets.left
            trailingConstraint.constant = insets.right
        }
    }
    
    weak var delegate: RadioButtonTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        label.font = .avenirRoman16
        label.textColor = .te_black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(RadioButtonTableViewCell.radioButtonTapped)))
        
        let radioUnchecked = R.image.uncheckedRadioButton()!
            .withRenderingMode(.alwaysTemplate)
            .tinted(with: .te_black)
        
        let radioChecked = R.image.checkedRadioButton()!
            .withRenderingMode(.alwaysTemplate)
            .tinted(with: .te_black)
        
        radioButton.setBackgroundImage(radioUnchecked, for: .normal)
        radioButton.setBackgroundImage(radioChecked, for: .selected)
        radioButton.setBackgroundImage(radioChecked, for: .highlighted)
        radioButton.adjustsImageWhenHighlighted = true
        radioButton.tintColor = .clear
        radioButton.addTarget(self, action: #selector(RadioButtonTableViewCell.radioButtonTapped), for: .touchUpInside)
        
        contentView.backgroundColor = .te_white
        label.backgroundColor = .clear
        radioButton.backgroundColor = .clear
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        radioButton.tag = 0
        delegate = nil
    }
    
    @objc private func radioButtonTapped(_ radioButton: UIButton) {
        print("radio button tapped")
        let isSelected = !self.radioButton.isSelected
        self.radioButton.isSelected = isSelected
        if isSelected {
            deselectOtherButton()
        }
        let tableView = self.superview as! UITableView
        let tappedCellIndexPath = tableView.indexPath(for: self)!
        delegate?.didToggleRadioButton(tappedCellIndexPath)
    }
    
    private func deselectOtherButton() {
        guard let tableView = self.superview as? UITableView,
            let tappedCellIndexPath = tableView.indexPath(for: self),
            let indexPaths = tableView.indexPathsForVisibleRows else { return }
        
        for indexPath in indexPaths {
            if indexPath.row != tappedCellIndexPath.row && indexPath.section == tappedCellIndexPath.section {
                let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row, section: indexPath.section)) as! RadioButtonTableViewCell
                cell.radioButton.isSelected = false
            }
        }
    }
}

extension RadioButtonTableViewCell: TableViewProtocol {
    static func instante(from tableView: UITableView, at indexPath: IndexPath) -> RadioButtonTableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.radioButtonTableViewCellReuseID, for: indexPath)!
    }
    
    static func register(in tableView: UITableView) {
        tableView.register(UINib(resource: R.nib.radioButtonTableViewCell), forCellReuseIdentifier: R.reuseIdentifier.radioButtonTableViewCellReuseID.identifier)
    }
}
