//
//  ResponseComboDetailModel.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 18/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

class ResponseComboDetailModel: Codable {
    var IDComboGoiDVSPChiTiet: Int?
    var IDComboGoiDVSP: Int?
    var IDDonVi: Int?
    var Loai: Int?
    var TenLoai: String?
    var TenDonVi: String?
    var MaDonVi: Int?
    var IDDichVu: Int?
    var MaDichVu: String?
    var TenDichVu: String?
    var AnhDichVu: String?
    var DonGia: Double?
    var SoLanDieuTri: Int?
    var SoNgayDieuTriLapLai: Int?
    var ThoiLuongThucHien: Int?
    
//    "IDComboGoiDVSPChiTiet":11,
//       "IDComboGoiDVSP":16,
//       "IDDonVi":null,
//       "Loai":1,
//       "TenLoai":"Dịch vụ",
//       "TenDonVi":null,
//       "MaDonVi":null,
//       "IDDichVu":94,
//       "MaDichVu":"DV000006",
//       "TenDichVu":"Khám Nội",
//       "AnhDichVu":"/ckfinder/userfiles/images/DVKham/anh-chinh-cdha.jpg",
//       "DonGia":100000.0,
//       "SoLanDieuTri":1.0,
//       "SoNgayDieuTriLapLai":1.0,
//       "ThoiLuongThucHien":1.0
    
    static func demoData() -> ResponseComboDetailModel {
        let result = ResponseComboDetailModel()
        result.IDComboGoiDVSPChiTiet = 7
        result.IDComboGoiDVSP = 15
        result.IDDonVi = nil
        result.Loai = 1
        result.TenLoai = "Dịch vụ"
        result.TenDonVi = nil
        result.MaDonVi = nil
        result.MaDichVu = nil
        result.TenDichVu = "Liệu trình trị mụn trên mặt 5 buổi"
        result.AnhDichVu = "/ckfinder/userfiles/images/DichVu/132370102704099501.jpg"
        result.DonGia = 7000000.0
        result.SoLanDieuTri = 5
        result.SoNgayDieuTriLapLai = 5
        result.ThoiLuongThucHien = 45
        return result
    }
}
