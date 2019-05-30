//
//  ViewController.swift
//  template-ios
//
//  Created by Vladimir Espinola on 3/19/19.
//  Copyright © 2019 vel. All rights reserved.
//

import UIKit
import MaterialComponents.MDCAppBar

class ExampleViewController: BaseViewController {
    @IBOutlet weak var tableView: FormTableView!
    
    private let presenter = ExamplePresenter()
    private lazy var appBar = MDCAppBar()
    private lazy var welcomeHeaderView: WelcomeHeaderView = {
        let header = WelcomeHeaderView()
        header.titleLabel.text = "FORM EXAMPLE"
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        create()
        configureAppBar()
        presenter.attach(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    deinit {
        presenter.dettach()
    }

    private func configure() {
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        
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

// MARK: MDCFlexibleHeaderViewLayoutDelegate
extension ExampleViewController: MDCFlexibleHeaderViewLayoutDelegate {
    
    public func flexibleHeaderViewController(_ flexibleHeaderViewController: MDCFlexibleHeaderViewController,
                                             flexibleHeaderViewFrameDidChange flexibleHeaderView: MDCFlexibleHeaderView) {
        
        welcomeHeaderView.update(withScrollPhasePercentage: flexibleHeaderView.scrollPhasePercentage)
    }
}

extension ExampleViewController: UIScrollViewDelegate {
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerView = appBar.headerViewController.headerView
        if scrollView == headerView.trackingScrollView {
            headerView.trackingScrollDidScroll()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let headerView = appBar.headerViewController.headerView
        if scrollView == headerView.trackingScrollView {
            headerView.trackingScrollDidEndDecelerating()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let headerView = appBar.headerViewController.headerView
        if scrollView == headerView.trackingScrollView {
            headerView.trackingScrollDidEndDraggingWillDecelerate(decelerate)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let headerView = appBar.headerViewController.headerView
        if scrollView == headerView.trackingScrollView {
            headerView.trackingScrollWillEndDragging(withVelocity: velocity, targetContentOffset: targetContentOffset)
        }
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

// MARK: UI Configuration
extension ExampleViewController {
    func configureAppBar() {
        self.addChild(appBar.headerViewController)
        
        appBar.navigationBar.backgroundColor = .clear
        appBar.headerViewController.layoutDelegate = self
        appBar.navigationBar.title = nil
        
        let headerView = appBar.headerViewController.headerView
        headerView.backgroundColor = .clear
        headerView.maximumHeight = WelcomeHeaderView.Constants.maxHeight
        headerView.minimumHeight = WelcomeHeaderView.Constants.minHeight
        
        welcomeHeaderView.frame = headerView.bounds
        headerView.insertSubview(welcomeHeaderView, at: 0)
        
        headerView.trackingScrollView = tableView
        headerView.trackingScrollView?.delegate = self
        
        appBar.addSubviewsToParent()
    }
}

