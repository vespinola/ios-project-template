//
//  ViewController.swift
//  template-ios
//
//  Created by Vladimir Espinola on 3/19/19.
//  Copyright © 2019 vel. All rights reserved.
//

import UIKit

class ExampleViewController: BaseViewController {
    @IBOutlet weak var tableView: CustomTableView!
    private let presenter = ExamplePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        create()
        presenter.attach(view: self)
    }
    
    deinit {
        presenter.dettach()
    }

    private func configure() {
        title = "Example"
        tableView.separatorStyle = .none
        
        LabelTableViewCell.register(in: tableView)
        ButtonTableViewCell.register(in: tableView)
        SwitchTableViewCell.register(in: tableView)
        RadioButtonTableViewCell.register(in: tableView)
        InputTableViewCell.register(in: tableView)
        DatePickerTableViewCell.register(in: tableView)
        
        tableView.initialize()
    }
    
    private func create() {
        let testSection = Section().configure { [unowned self] section in
            guard let tableView = self.tableView else { return }
            
            section.add([
                Field(for: { indexPath in
                    let cell = LabelTableViewCell.instante(from: tableView, at: indexPath)
                    cell.titleLabel.text = "This is just an example of Label"
                    cell.titleLabel.font = .avenirHeavy20
                    cell.padding = UIEdgeInsets(top: 20, left: 20, bottom: 4, right: 20)
                    return cell
                }),
                Field(for: { indexPath in
                    let cell = InputTableViewCell.instante(from: tableView, at: indexPath)
                    cell.textField.placeholder = "Write something funny here"
                    cell.validate = { $0.hasValue }
                    cell.errorMessage = "You have to write something"
                    return cell
                }),
                Field(for: { indexPath in
                    let cell = InputTableViewCell.instante(from: tableView, at: indexPath)
                    cell.textField.placeholder = "Tell me a secret"
                    cell.isSecureTextEntry = true
                    cell.validate = { $0.hasValue }
                    cell.errorMessage = "What's your secret?"
                    return cell
                }),
                Field(for: { indexPath in
                    let cell = InputTableViewCell.instante(from: tableView, at: indexPath)
                    cell.textField.placeholder = "Favourite Pet"
                    cell.pickerContent = [
                        PickerItem(title: "Cat", value: "Cat"),
                        PickerItem(title: "Dog", value: "Dog"),
                    ]
                    
                    cell.onFinishSelecting = { cell.textField.text = $0.title }
                    
                    return cell
                }),
                Field(for: { indexPath in
                    let cell = DatePickerTableViewCell.instante(from: tableView, at: indexPath)
                    cell.textField.placeholder = "Choose a date"
                    cell.onSelect = { print($0.formatted) }
                    return cell
                }),
                Field(for: { indexPath in
                    let cell = LabelTableViewCell.instante(from: tableView, at: indexPath)
                    cell.titleLabel.text = "Switches"
                    cell.titleLabel.font = .avenirHeavy16
                    cell.titleLabel.textAlignment = .left
                    return cell
                }),
                Field(for: { indexPath in
                    let cell = SwitchTableViewCell.instante(from: tableView, at: indexPath)
                    cell.configure(text: "Option 1 is \(cell.optionSwitch.isOn ? "enabled" : "disabled")", onChange: { isOn in
                        cell.label.text = "Option 1 is \(cell.optionSwitch.isOn ? "enabled" : "disabled")"
                    })
                    return cell
                }),
                Field(for: { indexPath in
                    let cell = SwitchTableViewCell.instante(from: tableView, at: indexPath)
                    cell.configure(text: "Option 2 is \(cell.optionSwitch.isOn ? "enabled" : "disabled")", onChange: { isOn in
                        cell.label.text = "Option 2 is \(cell.optionSwitch.isOn ? "enabled" : "disabled")"
                    })
                    return cell
                }),
                Field(for: { indexPath in
                    let cell = LabelTableViewCell.instante(from: tableView, at: indexPath)
                    cell.titleLabel.text = "Radio Buttons"
                    cell.titleLabel.font = .avenirHeavy16
                    cell.titleLabel.textAlignment = .left
                    return cell
                })
            ])
        }
        
        tableView.add(section: testSection)
        
        let radioSection = Section().configure { [unowned self] section in
            guard let tableView = self.tableView else { return }
            
            section.add([
                Field(for: { indexPath in
                    let cell = RadioButtonTableViewCell.instante(from: tableView, at: indexPath)
                    cell.label.text = "Choose 1"
                    cell.radioButton.isSelected = true
                    cell.insets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
                    cell.delegate = self
                    return cell
                }),
                Field(for: { indexPath in
                    let cell = RadioButtonTableViewCell.instante(from: tableView, at: indexPath)
                    cell.label.text = "Or Choose 2"
                    cell.insets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
                    cell.delegate = self
                    return cell
                }),
            ])
        }
        
        tableView.add(section: radioSection)
        
        tableView.add(section: Section().configure({ [unowned self] section in
            guard let tableView = self.tableView else { return }
            
            section.add(Field(for: { indexPath in
                let cell = ButtonTableViewCell.instante(from: tableView, at: indexPath)
                cell.padding = UIEdgeInsets(top: 30, left: 20, bottom: 30, right: 20)
                cell.configure(title: "TAP ME", onTap: {
                    self.presenter.doSomething()
                })
                return cell
            }))
        }))
    }
}

extension ExampleViewController: ExampleView {
    func performAfterCall() {
        Utilities.showSnackbar(with: "Everything was done!")
    }
    
    func startLoading() {
        showActivityIndicator()
    }
    
    func finishLoading() {
        hideActivityIndicator()
    }
    
    func performOnError(with message: String) {
        Utilities.showError(title: "FUTURE BANNER", message: message, in: self)
    }
}

extension ExampleViewController: RadioButtonTableViewCellDelegate {
    func didToggleRadioButton(_ indexPath: IndexPath) {
        //TODO
    }
}

