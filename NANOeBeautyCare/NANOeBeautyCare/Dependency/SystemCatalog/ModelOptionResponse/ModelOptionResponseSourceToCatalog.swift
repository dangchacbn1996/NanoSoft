//
//  ModelOptionResponseSourceToCatalog.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/9/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - ModelOptionResponseSourceToCatalog
struct ModelOptionResponseSourceToCatalog: Codable {
    var code: Int?
    var msg: String?
    var data: [ModelOptionResponseSourceToCatalogDatum]?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case data = "data"
    }
}

// MARK: - Datum
struct ModelOptionResponseSourceToCatalogDatum: Codable {
    var idNguonDen: Int?
    var tenNguonDen: String?

    enum CodingKeys: String, CodingKey {
        case idNguonDen = "IDNguonDen"
        case tenNguonDen = "TenNguonDen"
    }
}
