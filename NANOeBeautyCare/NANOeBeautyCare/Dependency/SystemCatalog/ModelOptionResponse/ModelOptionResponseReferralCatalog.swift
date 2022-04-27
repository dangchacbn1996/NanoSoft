//
//  ModelOptionResponseReferralCatalog.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/12/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - ModelOptionResponseReferralCatalog
struct ModelOptionResponseReferralCatalog: Codable {
    var code: Int?
    var msg: String?
    var data: [ModelOptionResponseReferralCatalogDatum]?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case data = "data"
    }
}

// MARK: - Datum
struct ModelOptionResponseReferralCatalogDatum: Codable {
    var idNguonGioiThieu: Int?
    var nguonGioiThieu: String?
    var soDienThoai: String?
    var trangThaiSuDung: Bool?

    enum CodingKeys: String, CodingKey {
        case idNguonGioiThieu = "IDNguonGioiThieu"
        case nguonGioiThieu = "NguonGioiThieu"
        case soDienThoai = "SoDienThoai"
        case trangThaiSuDung = "TrangThaiSuDung"
    }
}
