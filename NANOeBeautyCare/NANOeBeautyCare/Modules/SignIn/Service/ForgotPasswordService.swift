//
//  ForgotPasswordService.swift
//  NANOeBeautyCare
//
//  Created by Dom on 20/01/2021
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class ForgotPasswordService: BaseService {
    func forgotPasswordService(requestData: ForgotPasswordRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        
        let request = CommonStructModel<ForgotPasswordRequest>(group: "DmKhachHang", action: "QuenMatKhau", cmd: "DmKhachHang.QuenMatKhau", data: requestData)

        self.requestPOST(type: ModelBaseService<ForgotPasswordOptionalResponse>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
}

