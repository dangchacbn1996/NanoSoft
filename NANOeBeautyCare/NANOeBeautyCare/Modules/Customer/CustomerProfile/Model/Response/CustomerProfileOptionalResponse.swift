//
//  CustomerProfileOptionalResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/22/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

// MARK: - CustomerProfileOptionalResponse
struct CustomerProfileOptionalResponse: Codable {
    var sid: String?
    var id: Int?
    var idGioiTinh: Int?
    var loaiKhachHang: String?
    var hoTen: String?
    var idNgheNghiep: Int?
    var idNguonDen: Int?
    var idNguonGioiThieu: Int?
    var idPhongBan: Int?
    var mocDiemDat: Int?
    var ngaySinh: String?
    var tenGioiTinh: String?
    var tenHangThanhVien: String?
    var tenNgheNghiep: String?
    var tenPhongBan: String?
    var tenQuanHuyen: String?
    var tenTinhThanh: String?
    var tongDiemTichLuy: Int?
    var tongDiemTichLuyDaDung: Int?
    var allId: String?
    var anhKhachHang: String?
    var dienThoai: String?
    var email: String?
    var maQuanHuyen: String?
    var maTinhThanh: String?
    var diaChi: String?
    var maKhachHang: String?
    var Applinkext: String?

    enum CodingKeys: String, CodingKey {
        case sid = "sid"
        case id = "ID"
        case idGioiTinh = "IdGioiTinh"
        case loaiKhachHang = "LoaiKhachHang"
        case hoTen = "HoTen"
        case idNgheNghiep = "IDNgheNghiep"
        case idNguonDen = "IDNguonDen"
        case idNguonGioiThieu = "IDNguonGioiThieu"
        case idPhongBan = "IDPhongBan"
        case mocDiemDat = "MocDiemDat"
        case ngaySinh = "NgaySinh"
        case tenGioiTinh = "TenGioiTinh"
        case tenHangThanhVien = "TenHangThanhVien"
        case tenNgheNghiep = "TenNgheNghiep"
        case tenPhongBan = "TenPhongBan"
        case tenQuanHuyen = "TenQuanHuyen"
        case tenTinhThanh = "TenTinhThanh"
        case tongDiemTichLuy = "TongDiemTichLuy"
        case tongDiemTichLuyDaDung = "TongDiemTichLuyDaDung"
        case allId = "AllID"
        case anhKhachHang = "AnhKhachHang"
        case dienThoai = "DienThoai"
        case email = "Email"
        case maQuanHuyen = "MaQuanHuyen"
        case maTinhThanh = "MaTinhThanh"
        case diaChi = "DiaChi"
        case maKhachHang = "MaKhachHang"
        case Applinkext = "Applinkext"
    }
}
