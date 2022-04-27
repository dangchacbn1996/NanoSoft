//
//  SeriaDiscountOptionalResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/20/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - SeriaDiscountOptionalResponse
struct SeriaDiscountOptionalResponse: Codable {
    var code: Int?
    var msg: String?
    var idChuongTrinhKM: Int?
    var tenChuongTrinhKM: String?
    var loaiMa: Bool?
    var soLuong: Int?
    var hinhThucKM: Int?
    var tienOrPhanTram: Bool?
    var giamTang: Double?
    var loaiChuongTrinh: Int?
    var idDvSpTheoChuongTrinhKM: Int?
    var maKhuyenMai: String?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case idChuongTrinhKM = "IDChuongTrinhKM"
        case tenChuongTrinhKM = "TenChuongTrinhKM"
        case loaiMa = "LoaiMa"
        case soLuong = "SoLuong"
        case hinhThucKM = "HinhThucKM"
        case tienOrPhanTram = "TienOrPhanTram"
        case giamTang = "Giam_Tang"
        case loaiChuongTrinh = "LoaiChuongTrinh"
        case idDvSpTheoChuongTrinhKM = "IDDvSpTheoChuongTrinhKM"
        case maKhuyenMai = "MaKhuyenMai"
    }
}
