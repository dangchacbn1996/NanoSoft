//
//  ModelOptionResponseCardServiceCatalog.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/12/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - ModelOptionResponseCardServiceCatalog
struct ModelOptionResponseCardServiceCatalog: Codable {
    var code: Int?
    var msg: String?
    var data: [ModelOptionResponseCardServiceCatalogDatum]?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case data = "data"
    }
}

// MARK: - Datum
struct ModelOptionResponseCardServiceCatalogDatum: Codable {
    var totalRow: Int?
    var idTheDichVu: Int?
    var idLoaiTheDichVu: Int?
    var idPhongBan: Int?
    var tenPhongBan: String?
    var hanSuDung: String?
    var soLuongCon: Int?
    var giaTriThe: Int?
    var donGiaBan: Int?
    var tenTheDichVu: String?
    var tenLoaiTheDichVu: String?
    var anhTheDichVu: String?

    enum CodingKeys: String, CodingKey {
        case totalRow = "TotalRow"
        case idTheDichVu = "IDTheDichVu"
        case idLoaiTheDichVu = "IDLoaiTheDichVu"
        case idPhongBan = "IDPhongBan"
        case tenPhongBan = "TenPhongBan"
        case hanSuDung = "HanSuDung"
        case soLuongCon = "SoLuongCon"
        case giaTriThe = "GiaTriThe"
        case donGiaBan = "DonGiaBan"
        case tenTheDichVu = "TenTheDichVu"
        case tenLoaiTheDichVu = "TenLoaiTheDichVu"
        case anhTheDichVu = "AnhTheDichVu"
    }
}
