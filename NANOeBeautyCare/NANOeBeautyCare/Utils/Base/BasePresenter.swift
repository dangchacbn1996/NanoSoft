//
//  BasePresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

class BasePresenter<V> {
    
    var viewController: V?
    var context: RouteContext?
//    var service: S?
    
    func attachView(vc: V) {
        self.viewController = vc
    }
    
    func setContext(to context: RouteContext?) {
        self.context = context
    }
    
    func detachView() {
        viewController = nil
    }
}
