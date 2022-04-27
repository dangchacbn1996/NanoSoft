//
//  SignInOptionalResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

// MARK: - SignInOptionalResponse
struct SignInOptionalResponse: Codable {
    let code: Int?
    let msg: String?
    let data: SignInOptionalResponseDataClass?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case data = "data"
    }
}

// MARK: - DataClass
struct SignInOptionalResponseDataClass: Codable {
    let sid: String?
    let username: String?
    let nguoiDungID: Int?
    let userPhongBanID: Int?
    let tenPhongBan: String?
    let allID: String?
    let isCongTy: Bool?
    let isChiNhanh: Bool?
    let email: String?
    let soDienThoai: String?
    let avartar: String?
    let urlReportArb: String?
    let Applinkext:String?

    enum CodingKeys: String, CodingKey {
        case sid = "sid"
        case username = "Username"
        case nguoiDungID = "NguoiDungID"
        case userPhongBanID = "UserPhongBanID"
        case tenPhongBan = "TenPhongBan"
        case allID = "AllID"
        case isCongTy = "IsCongTy"
        case isChiNhanh = "IsChiNhanh"
        case email = "Email"
        case soDienThoai = "SoDienThoai"
        case avartar = "Avartar"
        case urlReportArb = "UrlReportArb"
        case Applinkext = "Applinkext"
    }
}
