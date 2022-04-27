//
//  CustomerSocialDetailService.swift
//  NANOeBeautyCare
//
//  Created by Dom on 11/10/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CustomerSocialDetailService: BaseService {
//    {"action":"LIST","checksum":"","cmd":"CongDongCauHoi.ChiTietTraLoiCauHoi","data":{"IDCauHoi":3},"group":"CongDongCauHoi","sid":"ab0650c3-5588-4921-8d15-a99e93a6e946","user":"0989989989"}
    func catalogQuestionDetailService(requestData: CustomerSocialDetailRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {

        let request = CommonStructModel<CustomerSocialDetailRequest>(group: "CongDongCauHoi", action: "LIST", cmd: "CongDongCauHoi.ChiTietTraLoiCauHoi", data: requestData)

        self.requestPOST(type: ModelBaseService<CustomerSocialDetailOptionalResponse>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
}

