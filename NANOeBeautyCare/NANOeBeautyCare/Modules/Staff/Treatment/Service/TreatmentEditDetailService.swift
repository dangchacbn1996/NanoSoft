//
//  TreatmentEditDetailService.swift
//  NANOeBeautyCare
//
//  Created by Dom on 11/9/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class TreatmentEditDetailService: BaseService {
    func postUpdateTreatmentService(requestData: TreatmentEditDetailRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<TreatmentEditDetailRequest>(group: "QuaTrinhDieuTri", action: "UPDATE", cmd: "QuaTrinhDieuTri.UpdateLieuTrinhDichVu", data: requestData)

        self.requestPOST(type: ModelBaseService<TreatmentReportOptionalResponse>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
}

