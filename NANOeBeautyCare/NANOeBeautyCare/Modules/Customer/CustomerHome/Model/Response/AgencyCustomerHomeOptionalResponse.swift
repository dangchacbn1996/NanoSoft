//
//  AgencyCustomerHomeOptionalResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 10/5/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - AgencyCustomerHomeOptionalResponse
struct AgencyCustomerHomeOptionalResponse: Codable {
    var idPhongBan: Int?
    var tenPhongBan: String?
    var maPhongBan: String?
    var diaChi: String?
    var soDienThoai: String?
    var allId: String?
    var maCongTy: String?
    var fax: String?
    var email: String?
    var logo: String?
    var website: String?
    var hotline: String?

    enum CodingKeys: String, CodingKey {
        case idPhongBan = "IDPhongBan"
        case tenPhongBan = "TenPhongBan"
        case maPhongBan = "MaPhongBan"
        case diaChi = "DiaChi"
        case soDienThoai = "SoDienThoai"
        case allId = "AllID"
        case maCongTy = "MaCongTy"
        case fax = "Fax"
        case email = "Email"
        case logo = "Logo"
        case website = "Website"
        case hotline = "Hotline"
    }
}
