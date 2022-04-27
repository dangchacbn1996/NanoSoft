//
//  TreatmentService.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/8/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class TreatmentService: BaseService {
    func listTreatmentService(requestData: TreatmentRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<TreatmentRequest>(group: "QuaTrinhDieuTri", action: "LIST", cmd: "QuaTrinhDieuTri.DanhSachDieuTri", data: requestData)

        self.requestPOST(type: ModelBaseService<[TreatmentOptionalResponse]>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
}

