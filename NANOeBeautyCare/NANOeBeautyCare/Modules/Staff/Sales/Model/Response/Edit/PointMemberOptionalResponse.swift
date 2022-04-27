//
//  PointMemberOptionalResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/20/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - PointMemberOptionalResponse
struct PointMemberOptionalResponse: Codable {
    var code: Int?
    var msg: String?
    var diemTichLuy: Int?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case diemTichLuy = "DiemTichLuy"
    }
}
