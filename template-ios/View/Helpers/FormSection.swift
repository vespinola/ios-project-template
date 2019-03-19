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
    
    var cellFor: ((IndexPath) -> UITableViewCell)!
    var cells: [Field] = []
    
    init(_ cells: [Field]? = nil){
        guard let newCells = cells else { return }
        self.cells = newCells
    }
    
    func add(_ cell: Field) {
        self.cells.append(cell)
    }
    
    func add(_ cells: [Field]){
        self.cells = self.cells + cells
    }
    
    @discardableResult
    func configure(_ callback: (FormSection) -> FormSection) -> FormSection {
        return callback(self)
    }
}

class Field {
    var cell: ((IndexPath) -> UITableViewCell)!
    var onSelect: ((IndexPath) -> Void)?
    var height: CGFloat!
    
    init(for cell: ((IndexPath) -> UITableViewCell)? = nil,
         onSelect: ((IndexPath) -> Void)? = nil, height: CGFloat = UITableView.automaticDimension) {
        self.cell = cell
        self.onSelect = onSelect
        self.height = height
    }
    
    @discardableResult
    func set(height: CGFloat) -> ((IndexPath) -> UITableViewCell)! {
        self.height = height
        return cell
    }
}
