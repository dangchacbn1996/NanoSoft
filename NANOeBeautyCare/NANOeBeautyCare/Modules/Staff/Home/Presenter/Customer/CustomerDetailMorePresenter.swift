//
//  CustomerDetailMorePresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/20/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol CustomerDetailMoreVC: BaseView {
    func initData(data:CustomerDetailOptionalResponse)
    func reloadData()
}


class CustomerDetailMorePresenter: BasePresenter<CustomerDetailMoreVC> {
    private let service = CustomerDetailMoreService()
    
    // MARK - Private Function
    var dataContext: CustomerDetailOptionalResponse?

    func initDataPresent() {
        self.dataContext = context?[RVContext]
        if let data = self.dataContext {
            self.viewController?.initData(data: data)
        }
    }
    
    func services() {
       
    }
}
