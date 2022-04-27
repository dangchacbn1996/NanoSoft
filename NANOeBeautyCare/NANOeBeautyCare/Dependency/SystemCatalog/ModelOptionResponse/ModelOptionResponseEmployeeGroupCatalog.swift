//
//  ModelOptionResponseEmployeeGroupCatalog.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/11/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - ModelOptionResponseEmployeeGroupCatalog
struct ModelOptionResponseEmployeeGroupCatalog: Codable {
    var code: Int?
    var msg: String?
    var data: [ModelOptionResponseEmployeeGroupCatalogDatum]?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case data = "data"
    }
}

// MARK: - ModelOptionResponseEmployeeGroupCatalogDatum
struct ModelOptionResponseEmployeeGroupCatalogDatum: Codable {
    var idNhomNhanVien: Int?
    var nhomNhanVien: String?
    var maMau: String?
    var phongBanID: Int?

    enum CodingKeys: String, CodingKey {
        case idNhomNhanVien = "IDNhomNhanVien"
        case nhomNhanVien = "NhomNhanVien"
        case maMau = "MaMau"
        case phongBanID = "PhongBanID"
    }
}
