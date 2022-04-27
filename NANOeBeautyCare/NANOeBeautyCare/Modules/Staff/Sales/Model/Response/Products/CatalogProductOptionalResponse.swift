//
//  CatalogProductOptionalResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/2/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - CatalogProductOptionalResponse
struct CatalogProductOptionalResponse: Codable {
    var totalRow: Int?
    var allID: String?
    var maNhomSanPham: String?
    var tenNhomSanPham: String?
    var tenLoaiSanPham: String?
    var maLoaiSanPham: String?
    var maHangSanXuat: String?
    var tenHangSanXuat: String?
    var id: Int?
    var tenSanPham: String?
    var loaiSanPhamID: Int?
    var nhomSanPhamID: Int?
    var hangSanXuatID: Int?
    var anhSanPham: String?
    var stt: Int?
    var tenDonVi: String?
    var maDonViMin: Int?
    var giaNiemYet: Double?
    var giaBan: Double?
    var ptGiamGiaMin: String?
    var ptGiamGia2: String?
    var ptGiamGiaMax: String?
    var isSelected: Bool = false
    var soLuongTonMin: Int = -1
    var tenDonViMin:String = ""

    enum CodingKeys: String, CodingKey {
        case totalRow = "TotalRow"
        case allID = "AllID"
        case maNhomSanPham = "MaNhomSanPham"
        case tenNhomSanPham = "TenNhomSanPham"
        case tenLoaiSanPham = "TenLoaiSanPham"
        case maLoaiSanPham = "MaLoaiSanPham"
        case maHangSanXuat = "MaHangSanXuat"
        case tenHangSanXuat = "TenHangSanXuat"
        case id = "ID"
        case tenSanPham = "TenSanPham"
        case loaiSanPhamID = "LoaiSanPhamID"
        case nhomSanPhamID = "NhomSanPhamID"
        case hangSanXuatID = "HangSanXuatID"
        case anhSanPham = "AnhSanPham"
        case stt = "STT"
        case tenDonVi = "TenDonVi"
        case maDonViMin = "MaDonViMin"
        case giaNiemYet = "GiaNiemYet"
        case giaBan = "GiaBan"
        case ptGiamGiaMin = "ptGiamGiaMin"
        case ptGiamGia2 = "ptGiamGia2"
        case ptGiamGiaMax = "ptGiamGiaMax"
    }
}
