//
//  ModelOptionResponseDistrictsByProvinceCodeCatalog.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/9/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
// MARK: - ModelOptionResponseDistrictsByProvinceCodeCatalog
struct ModelOptionResponseDistrictsByProvinceCodeCatalog: Codable {
    var code: Int?
    var msg: String?
    var data: [ModelOptionResponseDistrictsByProvinceCodeCatalogDatum]?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case data = "data"
    }
}

// MARK: - Datum
struct ModelOptionResponseDistrictsByProvinceCodeCatalogDatum: Codable {
    var id: Int?
    var maQuanHuyen: String?
    var tenQuanHuyen: String?
    var tenTiengAnh: String?
    var cap: String?
    var maTinhThanh: String?
    var tenTinhThanh: String?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case maQuanHuyen = "MaQuanHuyen"
        case tenQuanHuyen = "TenQuanHuyen"
        case tenTiengAnh = "TenTiengAnh"
        case cap = "Cap"
        case maTinhThanh = "MaTinhThanh"
        case tenTinhThanh = "TenTinhThanh"
    }
}
