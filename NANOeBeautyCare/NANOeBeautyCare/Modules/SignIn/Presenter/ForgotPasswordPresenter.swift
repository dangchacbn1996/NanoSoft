//
//  ForgotPasswordPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 20/01/2021
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol ForgotPasswordVC: BaseView {
    func initData(data:ViewForgotPassword)
    func reloadData()
    func alertVC(title: String)
}


class ForgotPasswordPresenter: BasePresenter<ForgotPasswordVC> {
    private let service = ForgotPasswordService()
    
    // MARK - Private Function
    var request = ForgotPasswordRequest(taiKhoan: "")

    func initDataPresent() {
        
    }
    
    func services() {
        self.service.forgotPasswordService(requestData: self.request, callBack: { (response, status, code) in
            self.service.handleObjectStatus(modelOptionalResponse: ForgotPasswordOptionalResponse.self, response: response, status, code, successBlock: { (repo) in
                if let data = repo.data {
                    self.viewController?.alertVC(title: data.msg ?? "")
                }
            }) { (repo) in

            }
        })
    }
}
