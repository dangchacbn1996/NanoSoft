//
//  ResponseComboServiceModel.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 18/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
class ResponseComboServiceModel: Codable {
    var IDComboGoiDVSP: Int?
    var TenComboGoiDVSP: String?
    var Anh: String?
    var HanSuDungComBo: Int?
    var MenhGia: Double?
    var GiaBan: Double?
    var GhiChu: String?
    var TrangThaiSuDung: Bool?
    var IDPhongBan: Int?
    var MaGoi: String?
    enum CodingKeys: String, CodingKey {
        case IDComboGoiDVSP = "IDComboGoiDVSP"
        case TenComboGoiDVSP = "TenComboGoiDVSP"
        case Anh = "Anh"
        case HanSuDungComBo = "HanSuDungComBo"
        case MenhGia = "MenhGia"
        case GiaBan = "GiaBan"
        case GhiChu = "GhiChu"
        case TrangThaiSuDung = "TrangThaiSuDung"
        case IDPhongBan = "IDPhongBan"
        case MaGoi = "MaGoi"
    }
    
    static func demoModel() -> ResponseComboServiceModel {
        let result = ResponseComboServiceModel()
        result.IDComboGoiDVSP = 13
        result.TenComboGoiDVSP = "Gói 1"
        result.Anh = nil
        result.HanSuDungComBo = 1
        result.MenhGia = 1150110.0
        result.GiaBan = 200000.0
        result.GhiChu = "2"
        result.TrangThaiSuDung = true
        result.IDPhongBan = 12
        result.MaGoi = nil
        return result
    }
    
}
