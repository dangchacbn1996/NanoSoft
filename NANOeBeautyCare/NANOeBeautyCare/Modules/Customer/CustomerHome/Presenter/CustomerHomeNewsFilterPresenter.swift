//
//  CustomerHomeNewsFilterPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 24/11/2020
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol CustomerHomeNewsFilterVC: BaseView {
    func initData(data:[NewCustomerHomeOptionalResponse])
    func initCategaryData(data:[NewCustomerHomeOptionalResponse])
    func reloadData()
}


class CustomerHomeNewsFilterPresenter: BasePresenter<CustomerHomeNewsFilterVC> {
    private let service = CustomerHomeNewsFilterService()
    
    // MARK - Private Function
    var requestNewCustomer = NewCustomerRequest()

    func initDataPresent() {
        self.categoryService()
    }

    func categoryService() {
        self.service.newCategoryCustomerService { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [NewCustomerHomeOptionalResponse].self, response: response, status, code, successBlock: { (repo) in
//                self.dataNews = repo.data ?? []
                self.viewController?.initCategaryData(data: repo.data ?? [])
                self.requestNewCustomer.idNhomNews =  0
                self.services()
            }) { (repo) in
            }
        }
    }
    
    func services() {
        self.service.newCustomerService(requestData: self.requestNewCustomer, callBack: { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [NewCustomerHomeOptionalResponse].self, response: response, status, code, successBlock: { (repo) in
//                self.dataNews = repo.data ?? []
                self.viewController?.initData(data: repo.data ?? [])
                self.viewController?.reloadData()
            }) { (repo) in
            }
        })
    }
}
