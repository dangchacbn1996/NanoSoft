//
//  CheckProductOptionalResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/2/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - CheckProductOptionalResponse
struct CheckProductOptionalResponse: Codable {
    var soLuongTonMin: Int?
    var soLuongTon2: Int?
    var soLuongTonMax: Int?
    var maDonVi2: Int?
    var maDonViMin: Int?
    var maDonViMax: Int?
    var code: Int?
    var msg: String?
    var chiNhanhID: String?
    var congTyID: Int?
    var tenDonVi2: String?
    var tenDonViMin: String?
    var tenDonViMax: String?
    var maDonViChoose: Int?
    var soLuongChoose: Int?
    var tenChoose: String?

    enum CodingKeys: String, CodingKey {
        case soLuongTonMin = "SoLuongTon_Min"
        case soLuongTon2 = "SoLuongTon_2"
        case soLuongTonMax = "SoLuongTon_Max"
        case maDonVi2 = "MaDonVi2"
        case maDonViMin = "MaDonViMin"
        case maDonViMax = "MaDonViMax"
        case code = "code"
        case msg = "msg"
        case chiNhanhID = "ChiNhanhID"
        case congTyID = "CongTyID"
        case tenDonVi2 = "TenDonVi2"
        case tenDonViMin = "TenDonViMin"
        case tenDonViMax = "TenDonViMax"
        case tenChoose = "tenChoose"
        case soLuongChoose = "soLuongChoose"
        case maDonViChoose = "maDonViChoose"
    }
}
