//
//  ServerSettingService.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/3/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class ServerSettingService: BaseService {
    func postAppServiceService(callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        self.baseURL = "http://123.30.240.41:8090"
        self.requestPOST(type: ServerSettingOptionalResponse.self, params: [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
}

