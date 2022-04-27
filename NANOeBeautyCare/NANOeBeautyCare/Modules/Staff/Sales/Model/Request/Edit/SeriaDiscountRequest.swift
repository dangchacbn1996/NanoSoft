//
//  SeriaDiscountRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/20/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - SeriaDiscountRequest
struct SeriaDiscountRequest: Codable {
    var id: Int?
    var loai: String?
    var maKhuyenMai: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case loai = "Loai"
        case maKhuyenMai = "MaKhuyenMai"
    }
}
