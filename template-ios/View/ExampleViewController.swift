//
//  ViewController.swift
//  template-ios
//
//  Created by Vladimir Espinola on 3/19/19.
//  Copyright © 2019 vel. All rights reserved.
//

import UIKit

class ExampleViewController: UIViewController {
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
        
        tableView.initialize()
    }
    
    private func create() {
        let testSection = FormSection().configure { [unowned self] section in
            guard let tableView = self.tableView else { return section }
            
            section.add([
                Field(for: { indexPath in
                    let cell = LabelTableViewCell.instante(from: tableView, at: indexPath)
                    cell.titleLabel.text = "This is just an example of label"
                    cell.padding = UIEdgeInsets(top: 20, left: 20, bottom: 4, right: 20)
                    return cell
                }),
                Field(for: { indexPath in
                    let cell = InputTableViewCell.instante(from: tableView, at: indexPath)
                    cell.textField.placeholder = "Put something funny here"
                    cell.validate = { $0.hasValue }
                    cell.errorMessage = "You have to define a text"
                    return cell
                }),
                Field(for: { indexPath in
                    let cell = InputTableViewCell.instante(from: tableView, at: indexPath)
                    cell.textField.placeholder = "Put something secret"
                    cell.isSecureTextEntry = true
                    cell.validate = { $0.hasValue }
                    cell.errorMessage = "Where's your secret key?"
                    return cell
                }),
                Field(for: { indexPath in
                    let cell = InputTableViewCell.instante(from: tableView, at: indexPath)
                    cell.textField.placeholder = "Pet"
                    cell.pickerContent = [
                        PickerItem(title: "Cat", value: "Cat"),
                        PickerItem(title: "Dog", value: "Dog"),
                    ]
                    
                    cell.onFinishSelecting = { item in
                        cell.textField.text = item.title
                    }
                    
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
                    cell.configure(text: "Option 1 is enable", onChange: { isOn in
                        print("option 1: \(isOn)")
                    })
                    return cell
                }),
                Field(for: { indexPath in
                    let cell = SwitchTableViewCell.instante(from: tableView, at: indexPath)
                    cell.configure(text: "Option 2 is enable", onChange: { isOn in
                        print("option 2: \(isOn)")
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
            
            return section
        }
        
        tableView.add(section: testSection)
        
        let radioSection = FormSection().configure { [unowned self] section in
            guard let tableView = self.tableView else { return section }
            
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
            
            return section
        }
        
        tableView.add(section: radioSection)
        
        tableView.add(section: FormSection().configure({ [unowned self] section in
            guard let tableView = self.tableView else { return section }
            
            section.add(Field(for: { indexPath in
                let cell = ButtonTableViewCell.instante(from: tableView, at: indexPath)
                cell.padding = UIEdgeInsets(top: 30, left: 20, bottom: 30, right: 20)
                cell.configure(title: "TAP ME", onTap: {
                    self.presenter.doSomething()
                })
                return cell
            }))
            
            return section
        }))
    }
}

extension ExampleViewController: ExampleView {
    func performAfterCall() {
        //TODO
    }
    
    func startLoading() {
        //TODO
    }
    
    func finishLoading() {
        //TODO
    }
    
    func performOnError(with message: String) {
        //TODO
    }
}

extension ExampleViewController: RadioButtonTableViewCellDelegate {
    func didToggleRadioButton(_ indexPath: IndexPath) {
        //TODO
    }
}

