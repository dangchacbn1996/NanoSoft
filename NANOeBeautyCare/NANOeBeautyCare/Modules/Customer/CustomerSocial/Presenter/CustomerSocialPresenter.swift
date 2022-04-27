//
//  CustomerSocialPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/22/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol CustomerSocialVC: BaseView {
    func initData(data:[CustomerSocialOptionalResponse])
    func resetTableView()
    func reloadData()
}


class CustomerSocialPresenter: BasePresenter<CustomerSocialVC> {
    private let service = CustomerSocialService()
    
    // MARK - Private Function
    var requestData = CustomerSocialRequest()
    var idNhomChuDe: Int = -1

    func initDataPresent() {
//        self.services()
        self.originCustomerService()
    }
    
    func originCustomerService() {
        self.requestData = CustomerSocialRequest()
        self.socialQuestionService()
    }
    
    func idCustomerService(idNhomChuDe: Int) {
        self.requestData = CustomerSocialRequest()
        self.requestData.idNhomChuDe = idNhomChuDe
        self.socialQuestionService()
    }
    func socialQuestionService() {
        self.service.catalogQuestionService(requestData: self.requestData, callBack: { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [CustomerSocialOptionalResponse].self, response: response, status, code, successBlock: { (repo) in
                if self.requestData.pageNum == 1 {
                    if (repo.data ?? []).count == 0 {
                        self.viewController?.resetTableView()
                        return
                    }
                }
                self.viewController?.initData(data: repo.data ?? [])
                self.viewController?.reloadData()
            }) { (repo) in

            }
        })
    }
}
