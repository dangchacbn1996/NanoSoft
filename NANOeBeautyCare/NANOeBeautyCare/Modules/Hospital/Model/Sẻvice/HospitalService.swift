//
//  HospitalService.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 26/05/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

class HospitalService: BaseService {
    static func showError(title: String = "Common.OK".localized, text: String, action: @escaping (() -> Void)) {
        let alertVC = PMAlertController(title: "\(CommonString)Alert".localized, description: text.uppercasedFirst, image: nil, style: .alert)
        
        alertVC.addAction(PMAlertAction(title: title, style: .default, action: action))
        
        UIApplication.topViewController()?.present(alertVC, animated: true, completion: nil)
    }
}

extension HospitalService {
    
    struct HospitalDetailRequest: Codable {
        var MaCongTy: String?

        enum CodingKeys: String, CodingKey {
            case MaCongTy = "MaCongTy"
        }
    }
    
    func hospitalDetail(model: HospitalDetailRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<HospitalDetailRequest>(group: "DmCongTy", action: "VIEW", cmd: "DmCongTy.ViewDetail", data: model)
        
        self.requestPOST(type: ModelBaseService<ResponseHospitalDetailModel>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    
    func hospitalKhaiBaoYTe(requestData: CreateAppointmentRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<CreateAppointmentRequest>(group: "DatLichHen", action: "", cmd: "DatLichHen.Add", data: requestData)

        self.requestPOST(type: ModelBaseService<CreateAppointmentOptionalResponse>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
}

//Notification
extension HospitalService {
    
    struct HosLoginNotifyRequest: Codable {
        var appid: String?
        var username: String?
        var type: String?
        
        enum CodingKeys: String, CodingKey {
            case appid = "appid"
            case username = "username"
            case type = "type"
        }
    }
    
    func hospitalLoginNotify(requestData: HosLoginNotifyRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<HosLoginNotifyRequest>(group: "Notification", action: "", cmd: "Notification.Login", data: requestData)
        
        self.requestPOST(type: ModelBaseService<ResponseGetMS>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
}
    
extension HospitalService {
    
    struct HosNotiListRequest: Codable {
        var SoDienThoai: String = SessionManager.shared.soDienThoai
        var page_num: Int?
        var page_size: Int?
    }
    
    func hospitalNotiList(requestData: HosNotiListRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<HosNotiListRequest>(group: "Notification", action: "", cmd: "Notification.List", data: requestData)
        
        self.requestPOST(type: ModelBaseOptionalResponseService<[HospitalNotifiItem]>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
}

extension HospitalService {
    
    struct HosNotiReadPage: Codable {
        var SoDienThoai: String?
        var IsView: Bool?
        var page_num: Int?
        var page_size: Int?
    }
    
    func hospitalNotiReadPage(requestData: HosNotiReadPage, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<HosNotiReadPage>(group: "Notification", action: "", cmd: "Notification.IsView", data: requestData)
        
        self.requestPOST(type: ModelBaseOptionalResponseService<ResponseGetMS>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
}

extension HospitalService {
    
    struct HosNotiReadNoti: Codable {
        var SoDienThoai: String?
        var IsView: Bool?
        var NotificationID: Int?
    }
    
    func hospitalNotiReadNoti(id: Int) {
        let request = CommonStructModel<HosNotiReadNoti>(group: "Notification", action: "", cmd: "Notification.IsView", data: HosNotiReadNoti(SoDienThoai: SessionManager.shared.soDienThoai, IsView: true, NotificationID: id))
        
        self.requestPOST(type: ModelBaseOptionalResponseService<ResponseGetMS>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            if SessionManager.shared.countNoti > 0 {
                SessionManager.shared.countNoti -= 1
            }
        }
    }
}

extension HospitalService {
    
    struct HosNotiReadCount: Codable {
        var SoDienThoai: String?
    }
    
    func hospitalNotiReadCount(callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<HosNotiReadCount>(group: "Notification", action: "", cmd: "Notification.CountIsNotView", data: HosNotiReadCount(SoDienThoai: SessionManager.shared.soDienThoai))
        
        self.requestPOST(type: ModelBaseOptionalResponseService<HospitalNotifyCount>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
}

//GetTaxi
extension HospitalService {
    struct HospitalGetTaxiRequest: Codable {
    }
    
    func hospitalGetTaxi(callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<HospitalGetTaxiRequest>(group: "DmTaxi", action: "", cmd: "DmTaxi.GetAll", data: HospitalGetTaxiRequest())
        
        self.requestPOST(type: ModelBaseOptionalResponseService<HospitalNotifyCount>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
}
