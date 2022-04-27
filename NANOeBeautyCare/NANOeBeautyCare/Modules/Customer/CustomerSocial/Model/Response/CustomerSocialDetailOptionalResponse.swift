//
//  CustomerSocialDetailOptionalResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 11/10/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

struct CustomerSocialDetailTableViewCell: Codable {
    var idCauHoi: Int?
    var idNhomChuDe: Int?
    var noiDungCauHoi: String?
    var khachHangId: Int?
    var tenPhongBan: String?
    var maPhongBan: String?
    var ngayTao: String?
    var hoTen: String?
    var dienThoai: String?
    var email: String?
    var cauTraLoi: CustomerSocialDetailOptionalResponseCauTraLoi?

    enum CodingKeys: String, CodingKey {
        case idCauHoi = "IDCauHoi"
        case idNhomChuDe = "IDNhomChuDe"
        case noiDungCauHoi = "NoiDungCauHoi"
        case khachHangId = "KhachHangID"
        case tenPhongBan = "TenPhongBan"
        case maPhongBan = "MaPhongBan"
        case ngayTao = "NgayTao"
        case hoTen = "HoTen"
        case dienThoai = "DienThoai"
        case email = "Email"
        case cauTraLoi = "CauTraLoi"
    }

}

// MARK: - CustomerSocialDetailOptionalResponse
struct CustomerSocialDetailOptionalResponse: Codable {
    var idCauHoi: Int?
    var idNhomChuDe: Int?
    var noiDungCauHoi: String?
    var khachHangId: Int?
    var tenPhongBan: String?
    var maPhongBan: String?
    var ngayTao: String?
    var hoTen: String?
    var dienThoai: String?
    var email: String?
    var cauTraLoi: [CustomerSocialDetailOptionalResponseCauTraLoi]?

    enum CodingKeys: String, CodingKey {
        case idCauHoi = "IDCauHoi"
        case idNhomChuDe = "IDNhomChuDe"
        case noiDungCauHoi = "NoiDungCauHoi"
        case khachHangId = "KhachHangID"
        case tenPhongBan = "TenPhongBan"
        case maPhongBan = "MaPhongBan"
        case ngayTao = "NgayTao"
        case hoTen = "HoTen"
        case dienThoai = "DienThoai"
        case email = "Email"
        case cauTraLoi = "CauTraLoi"
    }
}

// MARK: - CauTraLoi
struct CustomerSocialDetailOptionalResponseCauTraLoi: Codable {
    var noiDungTraLoi: String?
    var bacSyTuVan: String?
    var ngayTao: String?
    var trangThai: Int?
    var idCauHoi: Int?
    var idTraLoiCauHoi: Int?

    enum CodingKeys: String, CodingKey {
        case noiDungTraLoi = "NoiDungTraLoi"
        case bacSyTuVan = "BacSyTuVan"
        case ngayTao = "NgayTao"
        case trangThai = "TrangThai"
        case idCauHoi = "IDCauHoi"
        case idTraLoiCauHoi = "IDTraLoiCauHoi"
    }
}
