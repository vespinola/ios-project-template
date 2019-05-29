//
//  ATFloatingTextCell.swift
//  
//
//  Created by Vladimir Espinola Lezcano on 3/7/17.
//  Copyright © 2017. All rights reserved.
//

import UIKit
import MaterialComponents.MDCTextField

class DatePickerTableViewCell: UITableViewCell {
    @IBOutlet weak var textField: MDCTextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    private var pickerView: UIDatePicker!
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
    
    private lazy var textFieldControllerFloating: MDCTextInputControllerFilled = {
        let textFieldControllerFloating = MDCTextInputControllerFilled(textInput: textField) // Hold on as a property
        return textFieldControllerFloating
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        textField.delegate = self
        textField.tintColor = UIColor.black
        textField.font = .avenirRoman16
        textField.textColor = .te_black
        textField.adjustsFontSizeToFitWidth = true
        textField.addDoneButton() {
            self.datePickerValueChanged()
        }
        
        contentView.backgroundColor = .clear
        
        textFieldControllerFloating.errorColor = .te_pred
        textFieldControllerFloating.activeColor = .te_green
        textFieldControllerFloating.normalColor = .te_black
        textFieldControllerFloating.isFloatingEnabled = true
        textFieldControllerFloating.underlineViewMode = .always
        
        setupPicker()
    }
    
    private func setupPicker(){
        pickerView = UIDatePicker()
        pickerView.datePickerMode = .date
        pickerView.backgroundColor = .clear
        pickerView.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        textField.rightViewMode = .always
        
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let image = R.image.dropDown()?
            .withRenderingMode(.alwaysTemplate)
            .tinted(with: .te_black)
        
        let button = UIButton()
        button.setBackgroundImage(image, for: .normal)
        button.setBackgroundImage(image, for: .selected)
        button.setBackgroundImage(image, for: .highlighted)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.isSelected = true
        button.addTarget(self, action: #selector(InputTableViewCell.pickerView(_:didSelectRow:inComponent:)), for: .touchUpInside)
        container.addSubview(button)
        textField.rightView = container
        
        textField.inputView = pickerView
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        onBeginEditing = nil
    }
    
}

extension DatePickerTableViewCell: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        onBeginEditing?()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return false
    }
}

extension DatePickerTableViewCell {
    @objc func datePickerValueChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        textField.text = pickerView.date.formatted
        
        onSelect?(pickerView.date)
    }
}

extension DatePickerTableViewCell: TableViewProtocol {
    static func register(in tableView: UITableView) {
        tableView.register(UINib(resource: R.nib.datePickerTableViewCell), forCellReuseIdentifier: R.reuseIdentifier.datePickerTableViewCellReuseID.identifier)
    }
    
    static func instante(from tableView: UITableView, at indexPath: IndexPath) -> DatePickerTableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.datePickerTableViewCellReuseID, for: indexPath)!
    }
}
