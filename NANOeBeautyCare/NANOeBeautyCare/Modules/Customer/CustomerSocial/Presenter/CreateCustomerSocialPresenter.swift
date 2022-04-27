//
//  CreateCustomerSocialPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 23/11/2020
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol CreateCustomerSocialVC: BaseView {
    func initData(data:ViewCreateCustomerSocial)
    func reloadData()
    func alertShow(text: String)
}


class CreateCustomerSocialPresenter: BasePresenter<CreateCustomerSocialVC> {
    private let service = CreateCustomerSocialService()
    
    // MARK - Private Function
    var modelRequest = CreateCustomerSocialRequest(idNhomChuDe: "", isPublic: 1, noiDungCauHoi: "")

    func initDataPresent() {

    }
    
    func services() {
        self.service.createCatalogQuestionService(requestData: self.modelRequest) { (response, status, code) in
            self.service.handleObjectStatus(modelOptionalResponse: ResponseCommonObjectElement.self, response: response, status, code, successBlock: { (repo) in
                self.viewController?.alertShow(text: repo.msg ?? "")
                self.viewController?.reloadData()
            }) { (repo) in

            }
        }
    }
}
