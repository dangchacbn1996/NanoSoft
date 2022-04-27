//
//  ForgotPasswordRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 20/01/2021
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

struct ForgotPasswordRequest: Codable {
    var taiKhoan: String?

    enum CodingKeys: String, CodingKey {
        case taiKhoan = "TaiKhoan"
    }
}
