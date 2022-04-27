//
//  DetailTreatmentService.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/30/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class DetailTreatmentService: BaseService {
    func currentTreatmentService(requestData: DetailTreatmentRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
          let request = CommonStructModel<DetailTreatmentRequest>(group: "QuaTrinhDieuTri", action: "LIST", cmd: "QuaTrinhDieuTri.ChiTietLieuTrinhSuDungDichVu", data: requestData)

          self.requestPOST(type: ModelBaseService<[DetailTreatmentOptionalResponse]>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
              callBack(respo, status,code)
          }
      }
}

