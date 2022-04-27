//
//  AppointmentOptionalResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/8/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

// MARK: - Datum
struct AppointmentOptionalResponse: Codable {
    var totalRow: Int?
    var tieuDe: String?
    var maKhachHang: String?
    var tenKhachHangDatHen: String?
    var ngaySinh: String?
    var ghiChu: String?
    var listMaDichVuYeuCau: String?
    var ngayTao: String?
    var batDau: String?
    var ketThuc: String?
    var dateModified: String?
    var trangThai: Int?
    var soDienThoai: String?
    var email: String?
    var idLichHen: Int?
    var trangThaiText: String?
    var dichVuYeuCau: String?

    enum CodingKeys: String, CodingKey {
        case totalRow = "TotalRow"
        case tieuDe = "TieuDe"
        case maKhachHang = "MaKhachHang"
        case tenKhachHangDatHen = "TenKhachHangDatHen"
        case ngaySinh = "NgaySinh"
        case ghiChu = "GhiChu"
        case listMaDichVuYeuCau = "ListMaDichVuYeuCau"
        case ngayTao = "NgayTao"
        case batDau = "BatDau"
        case ketThuc = "KetThuc"
        case dateModified = "DateModified"
        case trangThai = "TrangThai"
        case soDienThoai = "SoDienThoai"
        case email = "Email"
        case idLichHen = "IDLichHen"
        case trangThaiText = "TrangThaiText"
        case dichVuYeuCau = "DichVuYeuCau"
    }
}
