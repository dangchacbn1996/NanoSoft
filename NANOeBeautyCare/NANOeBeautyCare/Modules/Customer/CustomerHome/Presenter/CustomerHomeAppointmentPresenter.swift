//
//  CustomerHomeAppointmentPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 10/10/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol CustomerHomeAppointmentVC: BaseView {
    func initData(data:SuggestionCustomerHomeOptionalResponse)
    func reloadData()
}


class CustomerHomeAppointmentPresenter: BasePresenter<CustomerHomeAppointmentVC> {
    private let service = CustomerHomeAppointmentService()
    
    // MARK - Private Function
    var dataContext: SuggestionCustomerHomeOptionalResponse?

    func initDataPresent() {
        self.dataContext = context?[RVContext]
        if let data = self.dataContext {
            self.viewController?.initData(data: data)
        }
        self.services()
    }
    
    func services() {
       
    }
}
