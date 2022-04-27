//
//  HomeService.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/8/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class HomeService: BaseService {
    func customerPortfolioService(requestData: HomeRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {

        let request = CommonStructModel<HomeRequest>(group: "DmKhachHang", action: "Index", cmd: "DmKhachHang.GetAll", data: requestData)

        self.requestPOST(type: ModelBaseService<[HomeOptionalResponse]>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
}

