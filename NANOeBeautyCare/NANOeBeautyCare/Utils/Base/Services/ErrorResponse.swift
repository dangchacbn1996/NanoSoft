//
//  ErrorResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

struct ErrorResponse: Codable {
    var code: Int?
    var msg: String?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
    }
}
