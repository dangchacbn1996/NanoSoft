//
//  ChangePasswordPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 20/01/2021
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol ChangePasswordVC: BaseView {
    func initData(data:ViewChangePassword)
    func reloadData()
    func alertVC(title: String)
}


class ChangePasswordPresenter: BasePresenter<ChangePasswordVC> {
    private let service = ChangePasswordService()
    
    // MARK - Private Function
    var request = ChangePasswordRequest(matKhau: "", matKhauMoi: "", taiKhoan: Common.BRAND_USER)

    func initDataPresent() {
        
    }
    
    func services() {
        self.service.changePasswordService(requestData: self.request, callBack: { (response, status, code) in
            self.service.handleObjectStatus(modelOptionalResponse: ChangePasswordOptionalResponse.self, response: response, status, code, successBlock: { (repo) in
                    self.viewController?.alertVC(title: repo.msg ?? "")
            }) { (repo) in

            }
        })
    }
}
