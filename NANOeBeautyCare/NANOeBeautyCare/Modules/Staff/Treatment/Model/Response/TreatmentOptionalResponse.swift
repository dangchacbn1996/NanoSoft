//
//  TreatmentOptionalResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/8/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

// MARK: - TreatmentOptionalResponse
struct TreatmentOptionalResponse: Codable {
    var totalRow: Int?
    var idLieuTrinhDieuTriDV: Int?
    var maHoSo: String?
    var idDichVu: Int?
    var idPhongBan: Int?
    var congTyID: Int?
    var listIDNhanVien: String?
    var idPhongDichVu: Int?
    var ngayDuKienThucHien: String?
    var ngayThucHien: String?
    var trangThaiLieuTrinh: Int?
    var trangThaiDieuTri: Int?
    var ghiChu: String?
    var hoSoID: Int?
    var bTrongNgoaiGoi: Int?
    var idGoiDichVu: String?
    var bTaoPhieuChiHuy: Bool?
    var soLuongDaThucHien: String?
    var maKhachHang: String?
    var khachHangID: Int?
    var hoTen: String?
    var tenDichVu: String?
    var dienThoai: String?
    var trangThaiDieuTriText: String?
    var trangThaiLieuTrinhText: String?
    var anhKhachHang: String?
    var urlServiceResult: String?

    enum CodingKeys: String, CodingKey {
        case totalRow = "TotalRow"
        case idLieuTrinhDieuTriDV = "IDLieuTrinhDieuTriDV"
        case maHoSo = "MaHoSo"
        case idDichVu = "IDDichVu"
        case idPhongBan = "IDPhongBan"
        case congTyID = "CongTyID"
        case listIDNhanVien = "ListIDNhanVien"
        case idPhongDichVu = "IDPhongDichVu"
        case ngayDuKienThucHien = "NgayDuKienThucHien"
        case ngayThucHien = "NgayThucHien"
        case trangThaiLieuTrinh = "TrangThaiLieuTrinh"
        case trangThaiDieuTri = "TrangThaiDieuTri"
        case ghiChu = "GhiChu"
        case hoSoID = "HoSoID"
        case bTrongNgoaiGoi = "bTrongNgoaiGoi"
        case idGoiDichVu = "IDGoiDichVu"
        case bTaoPhieuChiHuy = "bTaoPhieuChiHuy"
        case soLuongDaThucHien = "SoLuongDaThucHien"
        case maKhachHang = "MaKhachHang"
        case khachHangID = "KhachHangID"
        case hoTen = "HoTen"
        case tenDichVu = "TenDichVu"
        case dienThoai = "DienThoai"
        case trangThaiDieuTriText = "TrangThaiDieuTriText"
        case trangThaiLieuTrinhText = "TrangThaiLieuTrinhText"
        case anhKhachHang = "AnhKhachHang"
        case urlServiceResult = "UrlServiceResult"
    }
}
