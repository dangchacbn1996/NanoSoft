//
//  ModelOptionResponseStatusCatalog.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/9/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - ModelOptionResponseStatusCatalog
struct ModelOptionResponseStatusCatalog: Codable {
    var code: Int?
    var msg: String?
    var data: [ModelOptionResponseStatusCatalogDatum]?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case data = "data"
    }
}

// MARK: - Datum
struct ModelOptionResponseStatusCatalogDatum: Codable {
    var id: Int?
    var trangThai: String?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case trangThai = "TrangThai"
    }
}

// MARK: - ModelOptionResponseStatusCatalog
struct ModelOptionResponseInvoiceStatusCatalog: Codable {
    var code: Int?
    var msg: String?
    var data: [ModelOptionResponseInvoiceStatusCatalogDatum]?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case data = "data"
    }
}

// MARK: - Datum
struct ModelOptionResponseInvoiceStatusCatalogDatum: Codable {
    var id: Int?
    var trangThai: String?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case trangThai = "TrangThai"
    }
}
