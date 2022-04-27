//
//  ModelOptionResponseEmployeeAndSearchCatalog.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/11/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - ModelOptionResponseEmployeeAndSearchCatalog
struct ModelOptionResponseEmployeeAndSearchCatalog: Codable {
    var code: Int?
    var msg: String?
    var data: [ModelOptionResponseEmployeeAndSearchCatalogDatum]?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case data = "data"
    }
}

// MARK: - Datum
struct ModelOptionResponseEmployeeAndSearchCatalogDatum: Codable {
    var idNhanVien: Int?
    var tenNhanVien: String?
    var anhNhanVien: String?
    var moTa: String?
    var idPhongBan: Int?
    var idNhomNhanVien: Int?
    var nhomNhanVien: String?
    var soSao: Int?

    enum CodingKeys: String, CodingKey {
        case idNhanVien = "IDNhanVien"
        case tenNhanVien = "TenNhanVien"
        case anhNhanVien = "AnhNhanVien"
        case moTa = "MoTa"
        case idPhongBan = "IDPhongBan"
        case idNhomNhanVien = "IDNhomNhanVien"
        case nhomNhanVien = "NhomNhanVien"
        case soSao = "SoSao"
    }
}
