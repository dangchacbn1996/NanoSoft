//
//  DetailTreatmentOptionalResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/30/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

// MARK: - DetailTreatmentOptionalResponse
struct DetailTreatmentOptionalResponse: Codable {
    var idLieuTrinhDieuTriDV: Int?
    var hoSoID: Int?
    var idDichVu: Int?
    var listIDNhanVien: String?
    var idPhongDichVu: Int?
    var ngayDuKienThucHien: String?
    var ngayThucHien: String?
    var trangThaiDieuTri: Int?
    var trangThaiLieuTrinh: Int?
    var ghiChu: String?
    var soLuongDaThucHien: String?
    var tenPhongDichVu: String?
    var tenNhanVien: String?
    var ghiChu1: String?
    var trangThaiLieuTrinhText: String?
    var trangThaiDieuTriText: String?
    var urlProcessResult: String?

    enum CodingKeys: String, CodingKey {
        case idLieuTrinhDieuTriDV = "IDLieuTrinhDieuTriDV"
        case hoSoID = "HoSoID"
        case idDichVu = "IDDichVu"
        case listIDNhanVien = "ListIDNhanVien"
        case idPhongDichVu = "IDPhongDichVu"
        case ngayDuKienThucHien = "NgayDuKienThucHien"
        case ngayThucHien = "NgayThucHien"
        case trangThaiDieuTri = "TrangThaiDieuTri"
        case trangThaiLieuTrinh = "TrangThaiLieuTrinh"
        case ghiChu = "GhiChu"
        case soLuongDaThucHien = "SoLuongDaThucHien"
        case tenPhongDichVu = "TenPhongDichVu"
        case tenNhanVien = "TenNhanVien"
        case ghiChu1 = "GhiChu1"
        case trangThaiLieuTrinhText = "TrangThaiLieuTrinhText"
        case trangThaiDieuTriText = "TrangThaiDieuTriText"
        case urlProcessResult = "UrlProcessResult"
    }
}
