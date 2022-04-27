//
//  ModelRequestEmployeeAndSearchCatalog.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/11/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
// MARK: - ModelRequestEmployeeAndSearchCatalog
struct ModelRequestEmployeeAndSearchCatalog: Codable {
    var user: String?
    var sid: String?
    var group: String?
    var action: String?
    var cmd: String?
    var data: ModelRequestEmployeeAndSearchCatalogDataClass?
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
struct ModelRequestEmployeeAndSearchCatalogDataClass: Codable {
    var tenNhanVien: String?
    var idNhomNhanVien: Int?
    var pageSize: Int?
    var pageNum: Int?

    enum CodingKeys: String, CodingKey {
        case tenNhanVien = "TenNhanVien"
        case idNhomNhanVien = "IDNhomNhanVien"
        case pageSize = "page_size"
        case pageNum = "page_num"
    }
}
