//
//  PointMemberRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/20/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - PointMemberRequest
struct PointMemberRequest: Codable {
    var khachHangID: Int?

    enum CodingKeys: String, CodingKey {
        case khachHangID = "KhachHangID"
    }
}
