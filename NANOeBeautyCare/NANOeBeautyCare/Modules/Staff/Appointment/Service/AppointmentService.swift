//
//  AppointmentService.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/8/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class AppointmentService: BaseService {
    func appointmentScheduleService(requestData: AppointmentRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<AppointmentRequest>(group: "DatLichHen", action: "Index", cmd: "DatLichHen.GetAll", data: requestData)

        self.requestPOST(type: ModelBaseService<[AppointmentOptionalResponse]>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
}

