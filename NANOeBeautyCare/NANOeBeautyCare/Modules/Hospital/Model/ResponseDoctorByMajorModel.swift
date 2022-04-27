//
//  ResponseDoctorByMajorModel.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 17/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

class ResponseDoctorByMajorModel: Codable {
    var IDNhanVien: Int?
    var MaTuVan: String?
    var TenNhanVien: String?
    var AnhNhanVien: String?
    var MoTa: String?
    var IDNhomNhanVien: Int?
    var NhomNhanVien: String?
    var MaNhom: String?
    var MaKhoa: String?
    var TenKhoa: String?
    var IDKhoa: Int?
    
    enum CodingKeys: String, CodingKey {
        case IDNhanVien = "IDNhanVien"
        case MaTuVan = "MaTuVan"
        case TenNhanVien = "TenNhanVien"
        case AnhNhanVien = "AnhNhanVien"
        case MoTa = "MoTa"
        case IDNhomNhanVien = "IDNhomNhanVien"
        case NhomNhanVien = "NhomNhanVien"
        case MaNhom = "MaNhom"
        case MaKhoa = "MaKhoa"
        case TenKhoa = "TenKhoa"
        case IDKhoa = "IDKhoa"
    }
    
    static func demoData() -> (ResponseDoctorByMajorModel) {
        let result = ResponseDoctorByMajorModel()
        result.IDNhanVien = 2
        result.MaTuVan = "TAM_NTM"
        result.TenNhanVien = "Nguyễn Thị Minh Tâm"
        result.AnhNhanVien = "/ckfinder/userfiles/files/nhanvien.jpg"
        result.MoTa = "Nguyễn Thị Minh Tâm"
        result.IDNhomNhanVien = 17
        result.NhomNhanVien = "Bác sỹ"
        result.MaNhom = "BAC_SY"
        result.MaKhoa = "KHOA02"
        result.TenKhoa = "Tên khoa 012"
        result.IDKhoa = 3
        return result
    }
}
