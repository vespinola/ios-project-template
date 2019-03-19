//
//  ExamplePresenter.swift
//  template-ios
//
//  Created by Vladimir Espinola on 3/19/19.
//  Copyright © 2019 vel. All rights reserved.
//

import Foundation

protocol ExampleView: BaseViewProtocol {
    func performAfterCall()
}

class ExamplePresenter: BasePresenterProtocol {
    private weak var view: ExampleView?
    
    func attach(view: ExampleView) {
        self.view = view
    }
    
    func dettach() {
        view = nil
    }
    
    func doSomething() {
        view?.performAfterCall()
    }
}
