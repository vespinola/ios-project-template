//
//  ATFloatingTextCell.swift
//  
//
//  Created by Vladimir Espinola Lezcano on 3/7/17.
//  Copyright © 2017. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class DatePickerTextViewCell: UITableViewCell {
    @IBOutlet weak var textField: SkyFloatingLabelTextField!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    var pickerView: UIDatePicker!
    var onSelect: ((Date) -> Void)?
    var onBeginEditing: (() -> Void)?
    
    var insets: UIEdgeInsets! {
        didSet {
            topConstraint.constant = insets.top
            bottomConstraint.constant = insets.bottom
            leadingConstraint.constant = insets.left
            trailingConstraint.constant = insets.right
        }
    }

    static let defaultHeight: CGFloat = 60
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        textField.delegate = self
        textField.tintColor = UIColor.black
        textField.font = .avenirRoman16
        textField.textColor = .te_black
        textField.selectedTitleColor = .te_black
        textField.selectedLineColor = .te_black
        textField.selectedLineHeight = 2.0
        textField.lineHeight = 2.0
        textField.titleFormatter = { (text: String) in
            return text.lowercased().capitalized
        }
        textField.adjustsFontSizeToFitWidth = true
        textField.addDoneButton() {
            self.datePickerValueChanged()
        }
        
        contentView.backgroundColor = .clear
        
        pickerView = UIDatePicker()
        pickerView.datePickerMode = .date
        pickerView.backgroundColor = .clear
        pickerView.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        arrowImageView.image = R.image.arrowDown()?.withRenderingMode(.alwaysTemplate).tinted(with: .te_wine)
        arrowImageView.isHidden = false
        arrowImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(datePickerValueChanged)))
        textField.inputView = pickerView
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        onBeginEditing = nil
    }
    
}

extension DatePickerTextViewCell: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        onBeginEditing?()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return false
    }
}

extension DatePickerTextViewCell {
    @objc func datePickerValueChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        textField.text = pickerView.date.formatted
        
        onSelect?(pickerView.date)
    }
}

extension DatePickerTextViewCell: TableViewProtocol {
    static func register(in tableView: UITableView) {
        tableView.register(UINib(resource: R.nib.datePickerTextViewCell), forCellReuseIdentifier: R.reuseIdentifier.datePickerTextViewCellReuseID.identifier)
    }
    
    static func instante(from tableView: UITableView, at indexPath: IndexPath) -> DatePickerTextViewCell {
        return tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.datePickerTextViewCellReuseID, for: indexPath)!
    }
}
