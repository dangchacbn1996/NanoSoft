//
//  ModelOptionResponseServiceCatalog.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/12/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - ModelOptionResponseServiceCatalog
struct ModelOptionResponseServiceCatalog: Codable {
    var code: Int?
    var msg: String?
    var data: [ModelOptionResponseServiceCatalogDatum]?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case data = "data"
    }
}

// MARK: - Datum
struct ModelOptionResponseServiceCatalogDatum: Codable {
    var totalRow: Int?
    var idDichVu: Int?
    var tenDichVu: String?
    var anhDichVu: String?
    var idNhomDichVu: Int?
    var donGianNiemYet: Int?
    var allID: String?
    var thuTu: Int?
    var tenPhongBan: String?
    var tenNhomDichVu: String?
    var tomTat: String?
    var ngayDangTin: String?
    var ngayCapNhat: String?
    var idPhongBan: Int?
    var idDonGiaDV: Int?
    var donGia: Int?
    var ptGiamGia: String?

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
        case idPhongBan = "IDPhongBan"
        case idDonGiaDV = "IDDonGiaDV"
        case donGia = "DonGia"
        case ptGiamGia = "ptGiamGia"
    }
}
