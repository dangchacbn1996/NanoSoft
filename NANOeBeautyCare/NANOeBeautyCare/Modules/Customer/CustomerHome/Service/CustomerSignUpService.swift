//
//  CustomerSignUpService.swift
//  NANOeBeautyCare
//
//  Created by Dom on 22/01/2021
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CustomerSignUpService: BaseService {
    func createCustomerService(requestData: CustomerSignUpRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<CustomerSignUpRequest>(group: "DmKhachHang", action: "DangKy", cmd: "DmKhachHang.DangKy", data: requestData)
        
        self.requestPOST(type: ModelBaseService<CustomerSignUpOptionalResponse>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
}

