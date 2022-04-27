//
//  CustomerSearchOptionalResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/23/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - CustomerSearchOptionalResponseElement
struct CustomerSearchOptionalResponseElement: Codable {
    var hoTen: String?
    var id: Int?
    var dienThoai: String?
    var diaChi: String?
    var email: String?
    var ngaySinh: String?
    var maTinhThanh: String?
    var maQuanHuyen: String?
    var idLoaiKH: Int?
    var idNgheNghiep: Int?

    enum CodingKeys: String, CodingKey {
        case hoTen = "HoTen"
        case id = "ID"
        case dienThoai = "DienThoai"
        case diaChi = "DiaChi"
        case email = "Email"
        case ngaySinh = "NgaySinh"
        case maTinhThanh = "MaTinhThanh"
        case maQuanHuyen = "MaQuanHuyen"
        case idLoaiKH = "IDLoaiKH"
        case idNgheNghiep = "IDNgheNghiep"
    }
}

typealias CustomerSearchOptionalResponse = [CustomerSearchOptionalResponseElement]
