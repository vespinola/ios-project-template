//
//  CheckboxField.swift
//  Atlas-iOS
//
//  Created by Vladimir Espinola Lezcano on 4/23/18.
//  Copyright © 2018 roshka. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var optionSwitch: UISwitch!
    
    var onChange: ((Bool) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        
        label.font = .avenirRoman16
        label.textColor = .br_black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        contentView.backgroundColor = .clear

        optionSwitch.addTarget(self, action: #selector(optionSwitchOnChange(_:)), for: .valueChanged)
    }
    
    func configure(text: String, onChange: @escaping (Bool) -> Void) {
        self.label.text = text
        self.onChange = onChange
    }

    
    @objc private func optionSwitchOnChange(_ sender: UISwitch) {
        onChange?(sender.isOn)
    }
    
}

extension SwitchTableViewCell: TableViewProtocol {
    static func register(in tableView: UITableView) {
        tableView.register(UINib(resource: R.nib.switchTableViewCell), forCellReuseIdentifier: R.reuseIdentifier.switchTableViewCellReuseID.identifier)
    }
    
    static func instante(from tableView: UITableView, at indexPath: IndexPath) -> SwitchTableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.switchTableViewCellReuseID, for: indexPath)!
    }
}
