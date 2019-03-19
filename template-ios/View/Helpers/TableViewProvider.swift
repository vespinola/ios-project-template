//
//  TFormDelegate.swift

//
//  Created by Vladimir Espinola on 1/17/19.
//  Copyright © 2019 vel. All rights reserved.
//

import Foundation
import UIKit

class TableViewProvider: NSObject {
    var sections: FormSections = []
    var autoCornerRadius = false
}

extension TableViewProvider: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sections[indexPath.section].cells[indexPath.row].cell(indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section < sections.count else { return nil }
        return sections[section].headerFor?(section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard !sections.isEmpty else { return .leastNormalMagnitude }
        return sections[section].headerHeight 
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section < sections.count else { return nil }
        return sections[section].footerFor?(section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard !sections.isEmpty else { return .leastNormalMagnitude }
        return sections[section].footerHeight
    }
}

extension TableViewProvider: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].cells[indexPath.row].height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        sections[indexPath.section].cells[indexPath.row].onSelect?(indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? CustomTableViewCell, autoCornerRadius else { return }
        cell.isLast = indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1
        cell.isFirst = indexPath.row == 0
    }
}
