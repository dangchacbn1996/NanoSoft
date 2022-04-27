//
//  CustomerSocialRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/22/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

// MARK: - CustomerSocialRequest
struct CustomerSocialRequest: Codable {
    var idNhomChuDe: Int = 0
    var khachHangId: Int = SessionManager.shared.userInfo?.id ?? 0
    var noiDung: String = ""
    var isPublic: Int = 0
    var pageSize: Int = Int(kDefaultPageSize)
    var pageNum: Int = Int(kDefaultStartPage)

    enum CodingKeys: String, CodingKey {
        case idNhomChuDe = "IDNhomChuDe"
        case khachHangId = "KhachHangID"
        case noiDung = "NoiDung"
        case pageNum = "page_num"
        case isPublic = "IsPublic"
        case pageSize = "page_size"
    }
}
