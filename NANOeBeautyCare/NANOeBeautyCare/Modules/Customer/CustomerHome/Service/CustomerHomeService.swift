//
//  CustomerHomeService.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/22/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CustomerHomeService: BaseService {

    func agencyCustomerService(requestData: AgencyCustomerRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {

        let request = CommonStructModel<AgencyCustomerRequest>(group: "DmPhongBan", action: "LIST", cmd: "DmPhongBan.GetAll", data: requestData)

        self.requestPOST(type: ModelBaseService<[AgencyCustomerHomeOptionalResponse]>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    
    func getHospitalServices(requestData: HospitalServicesRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        
        let request = CommonStructModel<HospitalServicesRequest>(group: "", action: "LIST", cmd: "DmLoaiDichVu_KhachHang.GetAll", data: requestData)

        self.requestPOST(type: ModelBaseService<[HospitalServiceKindResponse]>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
        
    }
}

extension CustomerHomeService {
    struct HospitalServicesRequest : Codable {
        var IDKhachHang: Int?

//        enum CodingKeys: String, CodingKey {
//            case IDKhachHang = "IDKhachHang"
//        }
    }
    
    struct HospitalServiceKindResponse: Codable {
        var IDLoaiDV: Int?
        var MaLoaiDichVu: String?
        var TenLoaiDichVu: String?
        var IDPhongBan: Int?
        var Icon: String?
        
    //    enum CodingKeys: String, CodingKey {
    //        case IDLoaiDV: Int?
    //        case MaLoaiDichVu: String?
    //        case TenLoaiDichVu: String?
    //        case IDPhongBan: Int?
    //        case Icon: String?
    //    }
    }

}
