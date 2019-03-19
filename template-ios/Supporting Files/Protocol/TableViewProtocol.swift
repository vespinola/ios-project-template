//
//  TableViewProtocol.swift
//  
//
//  Created by Vladimir Espinola on 2/28/19.
//  Copyright © 2019 vel. All rights reserved.
//

import UIKit

protocol TableViewProtocol where Self: UITableViewCell {
    associatedtype Cell
    
    static func register(in tableView: UITableView)
    static func instante(from tableView: UITableView, at indexPath: IndexPath) -> Cell
}
