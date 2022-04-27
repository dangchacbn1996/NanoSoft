//
//  CustomerSocialService.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/22/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CustomerSocialService: BaseService {
    func catalogQuestionService(requestData: CustomerSocialRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {

        let request = CommonStructModel<CustomerSocialRequest>(group: "CongDongCauHoi", action: "LIST", cmd: "CongDongCauHoi.GetAll", data: requestData)

        self.requestPOST(type: ModelBaseService<[CustomerSocialOptionalResponse]>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
}

