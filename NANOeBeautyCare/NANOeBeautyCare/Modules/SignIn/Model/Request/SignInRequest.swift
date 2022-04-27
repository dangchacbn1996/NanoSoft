//
//  SignInRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

// MARK: - SignInRequest
struct SignInRequest: Codable {
    var domain: String
    var loaiTaiKhoan: String
    var maCongTy: String
    var password: String
    var user: String

    enum CodingKeys: String, CodingKey {
        case domain = "Domain"
        case loaiTaiKhoan = "LoaiTaiKhoan"
        case maCongTy = "MaCongTy"
        case password = "Password"
        case user = "User"
    }
    
}
