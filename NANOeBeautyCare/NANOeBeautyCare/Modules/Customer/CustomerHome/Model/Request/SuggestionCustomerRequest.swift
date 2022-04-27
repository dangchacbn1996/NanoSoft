//
//  SuggestionCustomerRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 10/5/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - SuggestionCustomerRequest
struct SuggestionCustomerRequest: Codable {
    var idNhomDichVu: Int = 0
    var pageSize: Int = Int(kDefaultPageSize)
    var pageNum: Int = Int(kDefaultStartPage)
    var tenDichVu: String = ""

    enum CodingKeys: String, CodingKey {
        case idNhomDichVu = "IDNhomDichVu"
        case pageNum = "page_num"
        case pageSize = "page_size"
        case tenDichVu = "TenDichVu"
    }
}
