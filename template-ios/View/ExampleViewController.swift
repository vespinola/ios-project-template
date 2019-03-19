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
        presenter.doSomething()
    }
    
    deinit {
        presenter.dettach()
    }

    private func configure() {
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
                    return cell
                }),
                Field(for: { indexPath in
                    let cell = InputTableViewCell.instante(from: tableView, at: indexPath)
                    cell.textField.placeholder = "Put something funny here"
                    return cell
                }),
                Field(for: { indexPath in
                    let cell = SwitchTableViewCell.instante(from: tableView, at: indexPath)
                    cell.label.text = "Option 1 is enable"
                    return cell
                }),
                Field(for: { indexPath in
                    let cell = SwitchTableViewCell.instante(from: tableView, at: indexPath)
                    cell.label.text = "Option 2 is enable"
                    return cell
                }),
            ])
            
            return section
        }
        
        tableView.add(section: testSection)
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

