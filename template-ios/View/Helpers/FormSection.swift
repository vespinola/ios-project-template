//
//  TableViewForm.swift
//
//  Created by Vladimir Espinola on 1/3/19.
//  Copyright © 2019 vel. All rights reserved.
//

import UIKit

typealias FormSections = [FormSection]

class FormSection {
    //view header section
    var headerFor: ((Int) -> UIView?)? = nil
    var headerHeight: CGFloat! = .leastNormalMagnitude
    
    //view footer section
    var footerFor: ((Int) -> UIView?)? = nil
    var footerHeight: CGFloat! = .leastNormalMagnitude
    
    var cells: [Field] = []
    
    init(_ cells: [Field]? = nil){
        guard let newCells = cells else { return }
        self.cells = newCells
    }
    
    func add(_ cell: Field) {
        self.cells.append(cell)
    }
    
    func add(_ cells: [Field]){
        self.cells += cells
    }
    
    @discardableResult
    func configure(_ handler: (FormSection) -> Void) -> Self {
        handler(self)
        return self
    }
}

class Field {
    var cell: ((IndexPath) -> UITableViewCell)!
    var onSelect: ((IndexPath) -> Void)?
    var height = UITableView.automaticDimension
    
    init(for cell: ((IndexPath) -> UITableViewCell)? = nil) {
        self.cell = cell
    }
    
    @discardableResult
    func performOnSelection(_ handler: @escaping (IndexPath) -> Void) -> Self {
        self.onSelect = handler
        return self
    }
    
    @discardableResult
    func set(height: CGFloat) -> Self {
        self.height = height
        return self
    }
}


