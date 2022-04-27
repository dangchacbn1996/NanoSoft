//
//  SuggestionCustomerHomeOptionalResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 10/5/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - SuggestionCustomerHomeOptionalResponse
struct SuggestionCustomerHomeOptionalResponse: Codable {
    var totalRow: Int?
    var idDichVu: Int?
    var tenDichVu: String?
    var anhDichVu: String?
    var idNhomDichVu: Int?
    var donGianNiemYet: Int?
    var allId: String?
    var thuTu: Int?
    var tenPhongBan: String?
    var tenNhomDichVu: String?
    var tomTat: String?
    var ngayDangTin: String?
    var ngayCapNhat: String?
    var noiDung: String?
    var idPhongBan: Int?
    var idDonGiaDv: Int?
    var donGia: Int?
    var ptGiamGia: String?

    enum CodingKeys: String, CodingKey {
        case totalRow = "TotalRow"
        case idDichVu = "IDDichVu"
        case tenDichVu = "TenDichVu"
        case anhDichVu = "AnhDichVu"
        case idNhomDichVu = "IDNhomDichVu"
        case donGianNiemYet = "DonGianNiemYet"
        case allId = "AllID"
        case thuTu = "ThuTu"
        case tenPhongBan = "TenPhongBan"
        case tenNhomDichVu = "TenNhomDichVu"
        case tomTat = "TomTat"
        case ngayDangTin = "NgayDangTin"
        case ngayCapNhat = "NgayCapNhat"
        case noiDung = "NoiDung"
        case idPhongBan = "IDPhongBan"
        case idDonGiaDv = "IDDonGiaDV"
        case donGia = "DonGia"
        case ptGiamGia = "ptGiamGia"
    }
}
