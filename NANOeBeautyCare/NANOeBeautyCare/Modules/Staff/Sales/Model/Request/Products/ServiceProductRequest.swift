//
//  ServiceProductRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/2/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - ServiceProductRequest
struct ServiceProductRequest: Codable {
    var idNhomDichVu: Int = 0
    var pageNum: Int = Int(kDefaultStartPage)
    var pageSize: Int = Int(kDefaultPageSize)
    var tenDichVu: String = ""

    enum CodingKeys: String, CodingKey {
        case idNhomDichVu = "IDNhomDichVu"
        case pageNum = "page_num"
        case pageSize = "page_size"
        case tenDichVu = "TenDichVu"
    }
}
