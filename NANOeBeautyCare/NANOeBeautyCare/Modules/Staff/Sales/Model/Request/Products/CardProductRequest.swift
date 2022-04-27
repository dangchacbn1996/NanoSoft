//
//  CardProductRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/2/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - CardProductRequest
struct CardProductRequest: Codable {
    var pageNum: Int = Int(kDefaultStartPage)
    var pageSize: Int = Int(kDefaultPageSize)
    var tenTheDichVu: String = ""

    enum CodingKeys: String, CodingKey {
        case pageNum = "page_num"
        case pageSize = "page_size"
        case tenTheDichVu = "TenTheDichVu"
    }
}



struct TestRequest: Codable {

}
