//
//  InputTableViewCell.swift
//  
//
//  Created by Vladimir Espinola on 1/8/19.
//  Copyright © 2019 vel. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

typealias PickerItem = (title: String, value: Any)

enum FloatingTextType {
    case quantity   // Not an amount (i.e. dollars or guaranies, a quantity of something, like checkbooks)
    case amount     // A currency
    case string
}

class InputTableViewCell: CustomTableViewCell {
    @IBOutlet weak var textField: SkyFloatingLabelTextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    
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
    
    var pickerView = UIPickerView()
    
    var onFinishSelecting: ((PickerItem) -> Void)?
    var onEdit: ((String?) -> Void)?
    var onSelect: ((PickerItem) -> Void)?
    var onBeginEditing: (() -> Bool)?
    var onReturn: (() -> Bool)? = nil
    var validate: ((String) -> Bool)? = nil
    
    var errorMessage = "Campo Inválido."
    
    var isSecureTextEntry: Bool? {
        didSet {
            textField.isSecureTextEntry = true
            setupPasswordVisibility()
        }
    }
    
    private var visibilityButton: UIButton?
    
    var _type: FloatingTextType! {
        didSet {
            guard _type == .amount, textLimit == nil else { return }
            textLimit = 34 //todo limit
        }
    }
    
    
    var type: FloatingTextType {
        get {
            return _type
        }
        set {
            _type = newValue
        }
    }
    
    var currency: CurrencyType = .pyg
    
    var textLimit: Int? // Max number of chars in field.
    var maxValue: Int?  // Max value of text field when interpreted as an integer.
    var onMaxValueSetToMax: Bool = false  // If a user exceeds the max value (`maxValue`), set the text to the max value.
    
    var hasCustomFormat = true
    
    static let defaultHeight: CGFloat = 60
    
    var pickerContent = [PickerItem](){
        didSet {
            setupPicker()
        }
    }
    
    var requiredUpdateConstraints = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        type = .string
        
        selectionStyle = .none
        textField.returnKeyType = .done
        textField.delegate = self
        textField.tintColor = UIColor.black
        textField.autocorrectionType = .no
        textField.font = UIFont.avenirRoman16
        textField.textColor = .black
        textField.selectedTitleColor = .br_black
        textField.selectedLineColor = .br_black
        textField.lineHeight = 2.0
        textField.selectedLineHeight = 2.0
        textField.titleFormatter = { [unowned self] (text: String) in
            guard self.hasCustomFormat else { return text }
            return text
        }
        textField.addDoneButton { [weak self] in let _ = self?.onReturn?() }
        textField.adjustsFontSizeToFitWidth = true
        textField.addTarget(self, action: #selector(InputTableViewCell.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func setupPicker(){
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        arrowImageView.image = R.image.arrowDown()?
            .withRenderingMode(.alwaysTemplate)
            .tinted(with: .br_wine)
        
        arrowImageView.isHidden = false
        arrowImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(InputTableViewCell.pickerView(_:didSelectRow:inComponent:))))
        pickerView.reloadAllComponents()
        textField.inputView = pickerView
    }
    
    private func setupPasswordVisibility() {
        textField.rightViewMode = .always
        let view = UIView(frame: CGRect(x: Metrics.applePadding, y: Metrics.applePadding, width: 44, height: 44))
        
        let button = UIButton()
        let unchecked = R.image.visibilityOff()!
            .withRenderingMode(.alwaysTemplate)
            .tinted(with: .br_black)
        
        let checked = R.image.visibility()!
            .withRenderingMode(.alwaysTemplate)
            .tinted(with: .br_black)
        
        button.setBackgroundImage(unchecked, for: .normal)
        button.setBackgroundImage(checked, for: .selected)
        button.setBackgroundImage(checked, for: .highlighted)
        button.addTarget(self, action: #selector(performVisibleButtonOnTap), for: .touchUpInside)
        button.frame = CGRect(x: Metrics.applePadding, y: Metrics.applePadding, width: 30, height: 30)
        button.isSelected = true 
        
        view.addSubview(button)
        
        visibilityButton = button
        
        textField.rightView = view
    }
    
    @objc func performVisibleButtonOnTap() {
        textField.togglePasswordVisibility()
        visibilityButton?.isSelected = textField.isSecureTextEntry
    }
    
    // This will notify us when something has changed on the textfield
    @objc func textFieldDidChange(_ floatingLabelTextField: SkyFloatingLabelTextField) {
        guard let validate = validate else { return }
        guard let text = floatingLabelTextField.text else { return }
        
        if !validate(text) {
            floatingLabelTextField.errorMessage = errorMessage
        }
        else {
            // The error message will only disappear when we reset it to nil or empty string
            floatingLabelTextField.errorMessage = ""
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pickerContent.removeAll()
        textField.inputView = nil
        textField.text = ""
        textField.keyboardType = .default
        type = .string
        
        onFinishSelecting = nil
        onEdit = nil
        onSelect = nil
        onBeginEditing = nil
        onReturn = nil
        validate = nil
        
        arrowImageView.isHidden = true
        
        textField.rightView = nil
        textField.rightViewMode = .never
    }
}

extension InputTableViewCell: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return onBeginEditing?() ?? true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let onReturn = onReturn else {
            textField.resignFirstResponder()
            return true
        }
        return onReturn()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard !pickerContent.isEmpty else {
            let _ = onReturn?()
            return
        }
        onFinishSelecting?(pickerContent[pickerView.selectedRow(inComponent: 0)])
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard pickerContent.isEmpty else { return false }
        let newText = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        let newLength = newText.count
        
        let verifyTextLength: (() -> Bool) = {
            guard let maxLength = self.textLimit else { return true }
            return  newLength <= maxLength
        }
        
        if type == .amount, verifyTextLength() {
            textField.text = textField.text?.reformatAmountInRange(range: range, string: string, currencyType: currency)
            onEdit?(textField.text!)
            return false
        }
        
        if type == .quantity, let max = self.maxValue {
            let quantity = Int(newText) ?? 0
            let isWithinMax = quantity <= max
            if !isWithinMax && onMaxValueSetToMax {
                textField.text = String(max)
                onEdit?(textField.text)
            } else {
                onEdit?(newText)
            }
            
            return isWithinMax
        }
        
        onEdit?(newText)
        return verifyTextLength()
    }
}

extension InputTableViewCell: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard pickerContent.count > 0 else { return }
        onSelect?(pickerContent[row])
    }
}

extension InputTableViewCell: UIPickerViewDataSource {
    // The title to return for the row and component (column) that's being passed in.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard pickerContent.count > 0 else { return nil }
        return pickerContent[row].0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerContent.count
    }
    
}

extension InputTableViewCell: TableViewProtocol {
    static func register(in tableView: UITableView) {
        tableView.register(UINib(resource: R.nib.inputTableViewCell), forCellReuseIdentifier: R.reuseIdentifier.inputTableViewCellReuseID.identifier)
    }
    
    static func instante(from tableView: UITableView, at indexPath: IndexPath) -> InputTableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.inputTableViewCellReuseID, for: indexPath)!
    }
}

extension InputTableViewCell {
    //MARK: Helpers
    
    func configure(_ callback: (SkyFloatingLabelTextField) -> Void) {
        callback(textField)
    }
    
}
