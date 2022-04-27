//
//  ServiceProductOptionalResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/2/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
// MARK: - ServiceProductOptionalResponseElement
struct ServiceProductOptionalResponse: Codable {
    var totalRow: Int?
    var idDichVu: Int?
    var tenDichVu: String?
    var anhDichVu: String?
    var idNhomDichVu: Int?
    var donGianNiemYet: Double?
    var allID: String?
    var thuTu: Int?
    var tenPhongBan: String?
    var tenNhomDichVu: String?
    var tomTat: String?
    var ngayDangTin: String?
    var ngayCapNhat: String?
    var noiDung: String?
    var idPhongBan: Int?
    var idDonGiaDV: Int?
    var donGia: Double?
    var ptGiamGia: String?
    var isSelected: Bool = false

    enum CodingKeys: String, CodingKey {
        case totalRow = "TotalRow"
        case idDichVu = "IDDichVu"
        case tenDichVu = "TenDichVu"
        case anhDichVu = "AnhDichVu"
        case idNhomDichVu = "IDNhomDichVu"
        case donGianNiemYet = "DonGianNiemYet"
        case allID = "AllID"
        case thuTu = "ThuTu"
        case tenPhongBan = "TenPhongBan"
        case tenNhomDichVu = "TenNhomDichVu"
        case tomTat = "TomTat"
        case ngayDangTin = "NgayDangTin"
        case ngayCapNhat = "NgayCapNhat"
        case noiDung = "NoiDung"
        case idPhongBan = "IDPhongBan"
        case idDonGiaDV = "IDDonGiaDV"
        case donGia = "DonGia"
        case ptGiamGia = "ptGiamGia"
    }
}
