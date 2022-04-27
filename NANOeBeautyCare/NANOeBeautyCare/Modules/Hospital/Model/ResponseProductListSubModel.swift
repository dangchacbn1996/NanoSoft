//
//  ResponseProductDetailModel.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 18/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

class ResponseProductListSubModel: Codable, Equatable {
    static func == (lhs: ResponseProductListSubModel, rhs: ResponseProductListSubModel) -> Bool {
        return lhs.ID == rhs.ID
    }
    
    var ID: Int?
    var IDLoaiDV: Int?
    var IDDichVu: Int?
    var MaDichVu: String?
    var TenDichVu: String?
    var AnhDichVu: String?
    var DonGia: Double?
    var SoLanDieuTri: Int?
    var SoNgayDieuTriLapLai: Int?
    var ThoiLuongThucHien: Double?
    
    static func demoData() -> (ResponseProductListSubModel) {
        let result = ResponseProductListSubModel()
        result.ID = 16
        result.IDLoaiDV = 1
        result.IDDichVu = 62
        result.MaDichVu = nil
        result.TenDichVu = "massage mặt 2"
        result.AnhDichVu = "/ckfinder/userfiles/images/DichVu/"
        result.DonGia = 1.0
        result.SoLanDieuTri = 1
        result.SoNgayDieuTriLapLai = 1
        result.ThoiLuongThucHien = 10.0
        return result
    }
//    "ID":16,
//    "IDLoaiDV":1,
//    "IDDichVu":62,
//    "MaDichVu":null,
//    "TenDichVu":"massage mặt 2",
//    "AnhDichVu":"/ckfinder/userfiles/images/DichVu/",
//    "DonGia":1.0,
//    "SoLanDieuTri":1.0,
//    "SoNgayDieuTriLapLai":1.0,
//    "ThoiLuongThucHien":10.0
    
}
