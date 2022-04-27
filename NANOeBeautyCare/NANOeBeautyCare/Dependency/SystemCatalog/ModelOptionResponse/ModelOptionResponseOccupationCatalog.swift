//
//  ModelOptionResponseOccupationCatalog.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/12/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - ModelOptionResponseOccupationCatalog
struct ModelOptionResponseOccupationCatalog: Codable {
    var code: Int?
    var msg: String?
    var data: [ModelOptionResponseOccupationCatalogDatum]?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case data = "data"
    }
}

// MARK: - Datum
struct ModelOptionResponseOccupationCatalogDatum: Codable {
    var idNgheNghiep: Int?
    var tenNgheNghiep: String?
    var trangThaiSuDung: Bool?
    var maAnhXa: String?

    enum CodingKeys: String, CodingKey {
        case idNgheNghiep = "IDNgheNghiep"
        case tenNgheNghiep = "TenNgheNghiep"
        case trangThaiSuDung = "TrangThaiSuDung"
        case maAnhXa = "MaAnhXa"
    }
}
