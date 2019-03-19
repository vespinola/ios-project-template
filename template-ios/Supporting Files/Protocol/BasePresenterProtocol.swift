//
//  BasePresenterProtocol.swift
//  
//
//  Created by Vladimir Espinola on 2/20/19.
//  Copyright © 2019 vel. All rights reserved.
//

import Foundation

protocol BasePresenterProtocol {
    associatedtype View
//    var view: View? { get set }
    func attach(view: View)
    func dettach()
}
