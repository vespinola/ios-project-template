//
//  CustomTableView.swift
//

//
//  Created by Vladimir Espinola on 1/17/19.
//  Copyright © 2019 vel. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding

class FormTableView: TPKeyboardAvoidingTableView {
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
    
    func add(section: Section) {
        section.index = sections.count
        sections.append(section)
    }
    
    func add(sections: [Section]) {
        for section in sections {
            self.add(section: section)
        }
    }
    
    func removeAllSections() {
        self.sections.removeAll()
    }
    
    func indexFor(section: Section) -> Int? {
        return sections.firstIndex(where: { $0 == section })
    }
    
    func reload(section: Section, animation: RowAnimation = .middle) {
        guard let index = indexFor(section: section) else {
            fatalError("Section not found")
        }
        
        reloadSections([index], with: animation)
    }
}
