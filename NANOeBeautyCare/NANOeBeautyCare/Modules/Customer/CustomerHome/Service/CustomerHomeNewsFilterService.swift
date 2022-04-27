//
//  CustomerHomeNewsFilterService.swift
//  NANOeBeautyCare
//
//  Created by Dom on 24/11/2020
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CustomerHomeNewsFilterService: BaseService {
    func newCategoryCustomerService(callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {

        let request = CommonStructModel<TestRequest>(group: "NewsDmNhom", action: "List", cmd: "NewsDmNhom.GetAll", data: TestRequest())

        self.requestPOST(type: ModelBaseService<[NewCustomerHomeOptionalResponse]>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
}

