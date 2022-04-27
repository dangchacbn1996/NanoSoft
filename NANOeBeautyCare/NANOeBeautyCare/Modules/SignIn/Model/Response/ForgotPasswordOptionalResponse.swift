//
//  ForgotPasswordOptionalResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 20/01/2021
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

struct ForgotPasswordOptionalResponse: Codable {
    var code: Int?
    var msg: String?
    var password: String?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case password = "Password"
    }
}
