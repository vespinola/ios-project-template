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
    
    #if DEBUG
    private var justForTest = true
    #endif
    
    func attach(view: ExampleView) {
        self.view = view
    }
    
    func dettach() {
        view = nil
    }
    
    func doSomething() {
        
        #if DEBUG
        guard justForTest else {
            justForTest = !justForTest
            view?.performOnError(with: "RANDOM ERROR")
            return
        }
        
        justForTest = !justForTest
        #endif
        
        view?.startLoading()
        
        delay(5) {
            self.view?.finishLoading()
            self.view?.performAfterCall()
        }
    }
}
