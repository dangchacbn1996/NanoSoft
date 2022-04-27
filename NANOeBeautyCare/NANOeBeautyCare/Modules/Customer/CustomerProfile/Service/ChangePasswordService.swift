//
//  ChangePasswordService.swift
//  NANOeBeautyCare
//
//  Created by Dom on 20/01/2021
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class ChangePasswordService: BaseService {
    func changePasswordService(requestData: ChangePasswordRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        
        let request = CommonStructModel<ChangePasswordRequest>(group: "DmKhachHang", action: "DoiMatKhau", cmd: "DmKhachHang.DoiMatKhau", data: requestData)

        self.requestPOST(type: ModelBaseService<ChangePasswordOptionalResponse>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
}

