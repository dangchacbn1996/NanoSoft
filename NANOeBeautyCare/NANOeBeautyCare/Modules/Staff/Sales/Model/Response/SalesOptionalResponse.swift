//
//  SalesOptionalResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/8/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

// MARK: - SalesOptionalResponse
struct SalesOptionalResponse: Codable {
    var totalRow: Int?
    var ngayDen: String?
    var tongTien: Double?
    var tongTienGiamGiaHD: Double?
    var tongTienThanhToan: Double?
    var hoTen: String?
    var maKhachHang: String?
    var idHoSo: Int?
    var maHoSo: String?
    var anhKhachHang: String?
    var trangThaiText: String?
    var ngayCapNhat: String?
    var trangThai: Int?
    var tongTienGiamGiaDVSPTHE: Double?
    var giamGiaTong: Int?

    enum CodingKeys: String, CodingKey {
        case totalRow = "TotalRow"
        case ngayDen = "NgayDen"
        case tongTien = "TongTien"
        case tongTienGiamGiaHD = "TongTienGiamGiaHD"
        case tongTienThanhToan = "TongTienThanhToan"
        case hoTen = "HoTen"
        case maKhachHang = "MaKhachHang"
        case idHoSo = "IDHoSo"
        case maHoSo = "MaHoSo"
        case anhKhachHang = "AnhKhachHang"
        case trangThaiText = "TrangThaiText"
        case ngayCapNhat = "NgayCapNhat"
        case trangThai = "TrangThai"
        case tongTienGiamGiaDVSPTHE = "TongTienGiamGia_DV_SP_THE"
        case giamGiaTong = "GiamGiaTong"
    }
}
