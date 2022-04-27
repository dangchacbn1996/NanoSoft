//
//  ModelOptionResponseProvincesCatalog.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/9/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - ModelOptionResponseProvincesCatalog
struct ModelOptionResponseProvincesCatalog: Codable {
    var code: Int?
    var msg: String?
    var data: [ModelOptionResponseProvincesCatalogDatum]?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case data = "data"
    }
}

// MARK: - Datum
struct ModelOptionResponseProvincesCatalogDatum: Codable {
    var id: Int?
    var maTinhThanh: String?
    var tenTinhThanh: String?
    var tenTiengAnh: String?
    var cap: String?
    var vungMien: Int?
    var maQuocGia: String?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case maTinhThanh = "MaTinhThanh"
        case tenTinhThanh = "TenTinhThanh"
        case tenTiengAnh = "TenTiengAnh"
        case cap = "Cap"
        case vungMien = "VungMien"
        case maQuocGia = "MaQuocGia"
    }
}
