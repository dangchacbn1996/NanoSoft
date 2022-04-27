//
//  CreateCustomerSocialRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 23/11/2020
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

// MARK: - CreateCustomerSocialRequest
struct CreateCustomerSocialRequest: Codable {
    var idNhomChuDe: String?
    var isPublic: Int?
    var khachHangId: Int = SessionManager.shared.userInfo?.id ?? 0
    var noiDungCauHoi: String?

    enum CodingKeys: String, CodingKey {
        case idNhomChuDe = "IDNhomChuDe"
        case khachHangId = "KhachHangID"
        case isPublic = "IsPublic"
        case noiDungCauHoi = "NoiDungCauHoi"
    }
}
