//
//  EditProductServiceService.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/7/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class EditProductServiceService: BaseService {
    func checkExitedService(requestData: CheckProductRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
            let request = CommonStructModel<CheckProductRequest>(group: "HoSoKhachHang", action: "VIEW", cmd: "HoSoKhachHang.KiemTraTonKho", data: requestData)
            self.requestPOST(type: ModelBaseService<CheckProductOptionalResponse>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
                callBack(respo, status,code)
            }
        }
}

