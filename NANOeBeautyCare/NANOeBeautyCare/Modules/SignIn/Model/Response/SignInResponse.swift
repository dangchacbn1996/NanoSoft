//
//  SignInResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

func transformationSignInResponse(model: SignInOptionalResponse?) -> SignInResponse {
    let dataOptional = model?.data
    let data = SignInResponseDataClass(sid: dataOptional?.sid ?? "", username: dataOptional?.username ?? "", nguoiDungID: dataOptional?.nguoiDungID ?? -1, userPhongBanID: dataOptional?.userPhongBanID ?? -1, tenPhongBan: dataOptional?.tenPhongBan ?? "", allID: dataOptional?.allID ?? "", isCongTy: dataOptional?.isCongTy ?? false, isChiNhanh: dataOptional?.isChiNhanh ?? false, email: dataOptional?.email ?? "", soDienThoai: dataOptional?.soDienThoai ?? "", avartar: dataOptional?.avartar ?? "", urlReportArb: dataOptional?.urlReportArb ?? "", Applinkext: dataOptional?.Applinkext ?? "")
    return SignInResponse(code: model?.code ?? -1, msg: model?.msg ?? "", data: data)
}

// MARK: - SignInResponse
struct SignInResponse: Codable {
    let code: Int
    let msg: String
    let data: SignInResponseDataClass

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case data = "data"
    }
}

// MARK: - DataClass
struct SignInResponseDataClass: Codable {
    let sid: String
    let username: String
    let nguoiDungID: Int
    let userPhongBanID: Int
    let tenPhongBan: String
    let allID: String
    let isCongTy: Bool
    let isChiNhanh: Bool
    let email: String
    let soDienThoai: String
    let avartar: String
    let urlReportArb: String
    let Applinkext: String

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

