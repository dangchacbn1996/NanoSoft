//
//  SaleIdxOptionalResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/20/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - SaleIdxOptionalResponse
struct SaleIdxOptionalResponse: Codable {
    var code: Int?
    var msg: String?
    var maHoSo: String?
    var stt: Int?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case maHoSo = "MaHoSo"
        case stt = "STT"
    }
}
