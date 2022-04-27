//
//  CreateCustomerSocialService.swift
//  NANOeBeautyCare
//
//  Created by Dom on 23/11/2020
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CreateCustomerSocialService: BaseService {

    func createCatalogQuestionService(requestData: CreateCustomerSocialRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {

        let request = CommonStructModel<CreateCustomerSocialRequest>(group: "CongDongCauHoi", action: "LIST", cmd: "CongDongCauHoi.Add", data: requestData)

        self.requestPOST(type: ModelBaseService<ResponseCommonObjectElement>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
}

