//
//  CustomerDetailHistoryPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/20/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol CustomerDetailHistoryVC: BaseView {
    func initData(data:[CustomerDetailHistoryResponseElement])
    func reloadData()
}


class CustomerDetailHistoryPresenter: BasePresenter<CustomerDetailHistoryVC> {
    private let service = CustomerDetailHistoryService()

    // MARK - Private Function
    var dataContext: CustomerDetailOptionalResponse?

    func initDataPresent() {
        self.dataContext = context?[RVContext]
        self.updateService()
    }

    func updateService() {
        if let data = self.dataContext {
                  self.services(idx: data.id)
        }
    }
    
    func services(idx: Int?) {
        self.service.customerDetailHistoryService(model: CustomerDetailRequest(id: idx), callBack: { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [CustomerDetailHistoryResponseElement].self, response: response, status, code, successBlock: { (repo) in
                if let data = repo.data {
                    self.viewController?.initData(data: data)
                    self.viewController?.reloadData()
                }
            }) { (repo) in

            }
        })
    }}
