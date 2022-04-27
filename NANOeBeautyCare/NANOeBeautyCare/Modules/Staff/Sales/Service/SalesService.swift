//
//  SalesService.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/8/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class SalesService: BaseService {
    func listSaleService(requestData: SalesRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<SalesRequest>(group: "HoSoKhachHang", action: "LIST", cmd: "HoSoKhachHang.GetAll", data: requestData)
        self.requestPOST(type: ModelBaseService<[SalesOptionalResponse]>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
}

