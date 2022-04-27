//
//  NewCustomerHomeOptionalResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 10/5/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - NewCustomerHomeOptionalResponse
struct NewCustomerHomeOptionalResponse: Codable {
    var totalRow: Int?
    var idNews: Int?
    var idNhomNews: Int?
    var tieuDe: String?
    var moTa: String?
    var tenNhomNews: String?
    var ngayCapNhat: String?
    var anhDaiDien: String?

    enum CodingKeys: String, CodingKey {
        case totalRow = "TotalRow"
        case idNews = "IDNews"
        case idNhomNews = "IDNhomNews"
        case tieuDe = "TieuDe"
        case moTa = "MoTa"
        case tenNhomNews = "TenNhomNews"
        case ngayCapNhat = "NgayCapNhat"
        case anhDaiDien = "AnhDaiDien"
    }
}
