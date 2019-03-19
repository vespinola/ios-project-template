//
//  CustomTableView.swift
//

//
//  Created by Vladimir Espinola on 1/17/19.
//  Copyright © 2019 vel. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding

class CustomTableView: TPKeyboardAvoidingTableView {
    var sections: FormSections {
        set {
            provider.sections = newValue
        }
        get {
            return provider.sections
        }
    }
    private var provider = TableViewProvider()
    
    var enableCornerRadiusPerSection: Bool! {
        didSet {
            provider.autoCornerRadius = enableCornerRadiusPerSection
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        initialize()
    }
    
    func initialize() {
        dataSource = provider
        delegate = provider
    }
    
    func add(section: FormSection) {
        sections.append(section)
    }
    
    func add(sections: [FormSection]) {
        self.sections = self.sections + sections
    }
    
    func removeAll() {
        self.sections.removeAll()
    }
}
