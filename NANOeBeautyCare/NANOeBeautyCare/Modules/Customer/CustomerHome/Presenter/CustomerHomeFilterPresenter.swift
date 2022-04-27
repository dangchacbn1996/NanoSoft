//
//  CustomerHomeFilterPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 24/11/2020
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol CustomerHomeFilterVC: BaseView {
    func initData(data:[SuggestionCustomerHomeOptionalResponse])
    func reloadData()
}

class CustomerHomeFilterPresenter: BasePresenter<CustomerHomeFilterVC> {
    private let service = CustomerHomeFilterService()
    
    // MARK - Private Function
    var requestSuggestionCustomer = SuggestionCustomerRequest()
    var item: ResponseProductListSubModel? = nil

    func initDataPresent() {
        self.services()
        self.item = context?["RVContext"]
    }

    func orginSerivce() {
        self.requestSuggestionCustomer  = SuggestionCustomerRequest()
//        self.services()
    }

    func services() {
        self.service.suggestionCustomerService(requestData: self.requestSuggestionCustomer, callBack: { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [SuggestionCustomerHomeOptionalResponse].self, response: response, status, code, successBlock: { (repo) in
                self.viewController?.initData(data: repo.data ?? [])
                self.viewController?.reloadData()
            }) { (repo) in
            }
        })
    }
}
