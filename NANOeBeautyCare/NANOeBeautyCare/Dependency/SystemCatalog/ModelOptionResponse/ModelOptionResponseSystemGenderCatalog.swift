//
//  ModelOptionResponseSystemGenderCatalog.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/9/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - ModelOptionResponseSystemGenderCatalog
struct ModelOptionResponseSystemGenderCatalog: Codable {
    var code: Int?
    var msg: String?
    var data: [ModelOptionResponseSystemGenderCatalogDatum]?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case data = "data"
    }
}

// MARK: - Datum
struct ModelOptionResponseSystemGenderCatalogDatum: Codable {
    var id: Int?
    var tenGioiTinh: String?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case tenGioiTinh = "TenGioiTinh"
    }
}

