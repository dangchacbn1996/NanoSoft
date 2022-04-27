//
//  CreateAppointmentService.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/22/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CreateAppointmentService: BaseService {
    func createAppointmentService(requestData: CreateAppointmentRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<CreateAppointmentRequest>(group: "DatLichHen", action: "ADD", cmd: "DatLichHen.ADD", data: requestData)

        self.requestPOST(type: ModelBaseService<CreateAppointmentOptionalResponse>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }

    func updateAppointmentService(requestData: CreateAppointmentRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<CreateAppointmentRequest>(group: "DatLichHen", action: "EDIT", cmd: "DatLichHen.Add", data: requestData)

        self.requestPOST(type: ModelBaseService<CreateAppointmentOptionalResponse>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }

    func readAppointmentService(requestData: DetailAppointmentRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<DetailAppointmentRequest>(group: "DatLichHen", action: "VIEW_DETAIL", cmd: "DatLichHen.ViewDetail", data: requestData)

        self.requestPOST(type: ModelBaseService<DetailAppointmentOptionalResponse>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
}

