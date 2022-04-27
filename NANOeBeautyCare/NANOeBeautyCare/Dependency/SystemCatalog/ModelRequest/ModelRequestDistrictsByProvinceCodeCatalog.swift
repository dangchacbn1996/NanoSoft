//
//  ModelRequestDistrictsByProvinceCodeCatalog.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/9/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - ModelRequestDistrictsByProvinceCodeCatalog
struct ModelRequestDistrictsByProvinceCodeCatalog: Codable {
    var user: String?
    var sid: String?
    var group: String?
    var action: String?
    var cmd: String?
    var data: ModelRequestDistrictsByProvinceCodeCatalogDataClass?
    var checksum: String?

    enum CodingKeys: String, CodingKey {
        case user = "user"
        case sid = "sid"
        case group = "group"
        case action = "action"
        case cmd = "cmd"
        case data = "data"
        case checksum = "checksum"
    }
}

// MARK: - DataClass
struct ModelRequestDistrictsByProvinceCodeCatalogDataClass: Codable {
    var maTinhThanh: String?

    enum CodingKeys: String, CodingKey {
        case maTinhThanh = "MaTinhThanh"
    }
}
