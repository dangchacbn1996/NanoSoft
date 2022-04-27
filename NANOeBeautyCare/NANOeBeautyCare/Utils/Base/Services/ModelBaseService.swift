//
//  ModelBaseService.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/20/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

struct ModelBaseOptionalResponseService<V: Codable>: Codable {
    var code: Int?
    var msg: String?
    var data: V?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case data = "data"
    }
}


struct ModelBaseService<V: Codable>: Codable {
    var code: Int?
    var msg: String?
    var data: V?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case data = "data"
    }
}


