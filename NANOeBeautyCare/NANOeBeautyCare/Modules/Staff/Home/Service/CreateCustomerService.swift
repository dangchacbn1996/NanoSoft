//
//  CreateCustomerService.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/9/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CreateCustomerService: BaseService {
    func createCustomerService(requestData: HomeCreateRequestDataClass, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<HomeCreateRequestDataClass>(group: "DmKhachHang", action: "ADD", cmd: "DmKhachHang.ADD", data: requestData)
        
        self.requestPOST(type: ModelBaseService<HomeOptionalResponse>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }

    func updateCustomerService(requestData: HomeCreateRequestDataClass, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<HomeCreateRequestDataClass>(group: "DmKhachHang", action: "EDIT", cmd: "DmKhachHang.EDIT", data: requestData)

        self.requestPOST(type: ModelBaseService<CustomerDetailOptionalResponse>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
}

