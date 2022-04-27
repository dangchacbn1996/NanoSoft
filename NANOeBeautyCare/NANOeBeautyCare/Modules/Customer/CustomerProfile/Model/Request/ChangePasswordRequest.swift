//
//  ChangePasswordRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 20/01/2021
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

struct ChangePasswordRequest: Codable {
    var matKhau: String?
    var matKhauMoi: String?
    var taiKhoan: String?

    enum CodingKeys: String, CodingKey {
        case matKhau = "MatKhau"
        case matKhauMoi = "MatKhauMoi"
        case taiKhoan = "TaiKhoan"
    }
}
