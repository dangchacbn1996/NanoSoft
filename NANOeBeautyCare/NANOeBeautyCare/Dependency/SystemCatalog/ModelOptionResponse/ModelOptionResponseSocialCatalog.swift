//
//  ModelOptionResponseSocialCatalog.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/12/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - ModelOptionResponseSocialCatalog
struct ModelOptionResponseSocialCatalog: Codable {
    var code: Int?
    var msg: String?
    var data: [ModelOptionResponseSocialCatalogDatum]?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case data = "data"
    }
}

// MARK: - ModelOptionResponseSocialCatalogDatum
struct ModelOptionResponseSocialCatalogDatum: Codable {
    var idNhomChuDe: Int?
    var tenNhomChuDe: String?

    enum CodingKeys: String, CodingKey {
        case idNhomChuDe = "IDNhomChuDe"
        case tenNhomChuDe = "TenNhomChuDe"
    }
}
