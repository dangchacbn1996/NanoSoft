//
//  ModelRequestServiceCatalog.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/12/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - ModelRequestServiceCatalog
struct ModelRequestServiceCatalog: Codable {
    var user: String?
    var sid: String?
    var group: String?
    var action: String?
    var cmd: String?
    var data: ModelRequestServiceCatalogDataClass?
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
struct ModelRequestServiceCatalogDataClass: Codable {
    var tenDichVu: String?
    var idNhomDichVu: Int?
    var pageSize: Int?
    var pageNum: Int?

    enum CodingKeys: String, CodingKey {
        case tenDichVu = "TenDichVu"
        case idNhomDichVu = "IDNhomDichVu"
        case pageSize = "page_size"
        case pageNum = "page_num"
    }
}
