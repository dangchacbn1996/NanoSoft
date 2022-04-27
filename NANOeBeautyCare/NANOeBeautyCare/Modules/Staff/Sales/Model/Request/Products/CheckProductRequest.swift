//
//  CheckProductRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/2/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - CheckProductRequest
struct CheckProductRequest: Codable {
    var sanPhamID: Int?

    enum CodingKeys: String, CodingKey {
        case sanPhamID = "SanPhamID"
    }
}
