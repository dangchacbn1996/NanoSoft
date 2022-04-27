//
//  NewCustomerRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 10/5/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
// MARK: - NewCustomerRequest
struct NewCustomerRequest: Codable {
    var idNhomNews: Int = 0
    var pageSize: Int = Int(kDefaultPageSize)
    var pageNum: Int = Int(kDefaultStartPage)
    var tieuDe: String = ""

    enum CodingKeys: String, CodingKey {
        case idNhomNews = "IDNhomNews"
        case pageNum = "page_num"
        case pageSize = "page_size"
        case tieuDe = "TieuDe"
    }
}
