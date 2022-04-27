//
//  CustomerDetailHistoryService.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/20/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CustomerDetailHistoryService: BaseService {
    func customerDetailHistoryService(model: CustomerDetailRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {

            let request = CommonStructModel<CustomerDetailRequest>(group: "DmKhachHang", action: "VIEW", cmd: "DmKhachHang.LichSuGiaoDich", data: model)

            self.requestPOST(type: ModelBaseService<[CustomerDetailHistoryResponseElement]>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
                callBack(respo, status,code)
            }
        }
}

