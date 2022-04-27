//
//  CustomerHomeNewsOptionalResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 10/10/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

// MARK: - CustomerHomeNewsOptionalResponse
struct CustomerHomeNewsOptionalResponse: Codable {
    var code: Int?
    var msg: String?
    var tenNhomNews: String?
    var idNews: Int?
    var tieuDe: String?
    var noiDung: String?
    var ngayCapNhat: String?
    var idPhongBan: Int?
    var idNhomNews: Int?
    var tenNguoiViet: String?
    var moTa: String?
    var anhDaiDien: String?
    var thuTu: Int?
    var tag: String?
    var danhSachTinTucLienQuan: [DanhSachTinTucLienQuan]?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case tenNhomNews = "TenNhomNews"
        case idNews = "IDNews"
        case tieuDe = "TieuDe"
        case noiDung = "NoiDung"
        case ngayCapNhat = "NgayCapNhat"
        case idPhongBan = "IDPhongBan"
        case idNhomNews = "IDNhomNews"
        case tenNguoiViet = "TenNguoiViet"
        case moTa = "MoTa"
        case anhDaiDien = "AnhDaiDien"
        case thuTu = "ThuTu"
        case tag = "Tag"
        case danhSachTinTucLienQuan = "DanhSachTinTucLienQuan"
    }
}

// MARK: - DanhSachTinTucLienQuan
struct DanhSachTinTucLienQuan: Codable {
    var idNews: Int?
    var tieuDe: String?
    var ngayCapNhat: String?
    var moTa: String?
    var anhDaiDien: String?
    var idNhomNews: Int?
    var tenNhomNews: String?
    var thuTu: Int?
    var tenNguoiViet: String?

    enum CodingKeys: String, CodingKey {
        case idNews = "IDNews"
        case tieuDe = "TieuDe"
        case ngayCapNhat = "NgayCapNhat"
        case moTa = "MoTa"
        case anhDaiDien = "AnhDaiDien"
        case idNhomNews = "IDNhomNews"
        case tenNhomNews = "TenNhomNews"
        case thuTu = "ThuTu"
        case tenNguoiViet = "TenNguoiViet"
    }
}
