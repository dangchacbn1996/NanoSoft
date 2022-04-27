//
//  CustomerHomeNewsService.swift
//  NANOeBeautyCare
//
//  Created by Dom on 10/10/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CustomerHomeNewsService: BaseService {
    func newsCustomerDetailService(requestData: CustomerHomeNewsRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {

        let request = CommonStructModel<CustomerHomeNewsRequest>(group: "NewsNoiDung", action: "VIEW", cmd: "NewsNoiDung.ChiTietTinTuc", data: requestData)

        self.requestPOST(type: ModelBaseService<CustomerHomeNewsOptionalResponse>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
}

