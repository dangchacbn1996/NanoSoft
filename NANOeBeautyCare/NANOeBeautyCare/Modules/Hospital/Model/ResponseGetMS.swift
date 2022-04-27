//
//  ResponseGetMS.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 04/08/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

class ResponseGetMS: Codable {
    var code: Int?
    var msg: String?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
    }
}
