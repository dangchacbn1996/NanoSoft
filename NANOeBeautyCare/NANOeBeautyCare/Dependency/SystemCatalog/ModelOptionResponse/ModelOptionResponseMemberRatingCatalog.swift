//
//  ModelOptionResponseMemberRatingCatalog.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/12/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - ModelOptionResponseMemberRatingCatalog
struct ModelOptionResponseMemberRatingCatalog: Codable {
    var code: Int?
    var msg: String?
    var data: [ModelOptionResponseMemberRatingCatalogDatum]?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case data = "data"
    }
}

// MARK: - Datum
struct ModelOptionResponseMemberRatingCatalogDatum: Codable {
    var idXepHangThanhVien: Int?
    var tenHangThanhVien: String?
    var mocDiemDat: Int?
    var ghiChu: String?

    enum CodingKeys: String, CodingKey {
        case idXepHangThanhVien = "IDXepHangThanhVien"
        case tenHangThanhVien = "TenHangThanhVien"
        case mocDiemDat = "MocDiemDat"
        case ghiChu = "GhiChu"
    }
}

