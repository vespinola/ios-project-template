//
//  BaseViewProtocol.swift
//  
//
//  Created by Vladimir Espinola on 2/20/19.
//  Copyright © 2019 vel. All rights reserved.
//

import Foundation

protocol BaseViewProtocol: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func performOnError(with message: String)
}
