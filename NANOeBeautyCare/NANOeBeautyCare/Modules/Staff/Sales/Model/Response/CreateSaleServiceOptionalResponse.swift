//
//  CreateSaleServiceOptionalResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/30/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

struct CreateSaleServiceOptionalResponse: Codable {
    var idHoSo: Int?
    var maHoSo: String?
    var maKhachHang: String?
    var khachHangID: Int?
    var hoTen: String?
    var ghiChu: String?
    var stt: Int?
    var tongTienGiamGiaHD: Double?
    var tongTienThanhToan: Double?
    var tongTien: Double?
    var tongTienGiamGiaDVSPTHE: Double?
    var trangThai: Int?
    var bSuDungGoi: String?
    var trangThaiText: String?
    var anhKhachHang: String?
    var ngayDen: String?
    var dichVuSanPhamThe: [DichVuSanPhamThe]?
    var lstGiamGiaHoSoKhachHang: [LstGiamGiaHoSoKhachHang]?
    
    enum CodingKeys: String, CodingKey {
        case idHoSo = "IDHoSo"
        case maHoSo = "MaHoSo"
        case maKhachHang = "MaKhachHang"
        case khachHangID = "KhachHangID"
        case hoTen = "HoTen"
        case ghiChu = "GhiChu"
        case stt = "STT"
        case tongTienGiamGiaHD = "TongTienGiamGiaHD"
        case tongTienThanhToan = "TongTienThanhToan"
        case tongTien = "TongTien"
        case tongTienGiamGiaDVSPTHE = "TongTienGiamGia_DV_SP_THE"
        case trangThai = "TrangThai"
        case bSuDungGoi = "bSuDungGoi"
        case trangThaiText = "TrangThaiText"
        case anhKhachHang = "AnhKhachHang"
        case ngayDen = "NgayDen"
        case dichVuSanPhamThe = "DichVuSanPhamThe"
        case lstGiamGiaHoSoKhachHang = "lstGiamGiaHoSoKhachHang"
    }
}

// MARK: - DichVuSanPhamThe
struct DichVuSanPhamThe: Codable {
    var rowID: Int?
    var loai: String?
    var id: Int?
    var ten: String?
    var soLuong: Double?
    var donGia: Double?
    var thanhTien: Double?
    var giamGia: Double?
    var thanhTienGiamGia: Double?
    var tienThanhToan: Double?
    var htGiamGia: Double?
    var anhDaiDien: String?
    var tenDonVi: String?
    var htTraHoaHong: Int?
    var maGiamGiaTien: Int?
    var idNguonGioiThieu: Int?
    var listIDTuVanVien: String?
    var maGiamGia: String?
    var idCT: Int?
    var trangThai: Int?
    var listIDNhanVien: String?
    var sdtNguonGioiThieu: String?
    var hoaHongTraNVTuVan: Double?
    var maQuanLyDV: String?
    var nguonGioiThieu: String?
    var listTenNhanVienTuVan: String?
    var listTenNhanVien: String?

    //NEW
    var donvi: Int?
    var nguonGioiThieuSoDienThoai: String?
    var nguonGioiThieuTen: String?
    var thanhTienThanhToan: Double?
    var tienGiam: Double?
    var tienHoaHong: Double?
    var type: String?
    
    enum CodingKeys: String, CodingKey {
        case rowID = "RowID"
        case loai = "Loai"
        case id = "Id"
        case ten = "Ten"
        case soLuong = "SoLuong"
        case donGia = "DonGia"
        case thanhTien = "ThanhTien"
        case giamGia = "GiamGia"
        case thanhTienGiamGia = "ThanhTienGiamGia"
        case tienThanhToan = "TienThanhToan"
        case htGiamGia = "HTGiamGia"
        case anhDaiDien = "AnhDaiDien"
        case tenDonVi = "TenDonVi"
        case htTraHoaHong = "HTTraHoaHong"
        case maGiamGiaTien = "MaGiamGia_Tien"
        case idNguonGioiThieu = "IDNguonGioiThieu"
        case listIDTuVanVien = "ListIDTuVanVien"
        case maGiamGia = "MaGiamGia"
        case idCT = "idCT"
        case trangThai = "TrangThai"
        case listIDNhanVien = "ListIDNhanVien"
        case sdtNguonGioiThieu = "SDTNguonGioiThieu"
        case hoaHongTraNVTuVan = "HoaHongTraNVTuVan"
        case maQuanLyDV = "MaQuanLyDV"
        case nguonGioiThieu = "NguonGioiThieu"
        case listTenNhanVienTuVan = "ListTenNhanVienTuVan"
        case listTenNhanVien = "ListTenNhanVien"


        case donvi = "donvi"
        case nguonGioiThieuSoDienThoai = "nguonGioiThieu_SoDienThoai"
        case nguonGioiThieuTen = "nguonGioiThieu_Ten"
        case thanhTienThanhToan = "ThanhTienThanhToan"
        case tienGiam = "TienGiam"
        case tienHoaHong = "TienHoaHong"
        case type = "type"
    }
}

// MARK: - LstGiamGiaHoSoKhachHang
struct LstGiamGiaHoSoKhachHang: Codable {
    var giamGia: Int?
    var htGiamGia: Int?
    var maGiamGia: String?
    var thanhTienGiamGia: Int?

    enum CodingKeys: String, CodingKey {
        case giamGia = "GiamGia"
        case htGiamGia = "HTGiamGia"
        case maGiamGia = "MaGiamGia"
        case thanhTienGiamGia = "ThanhTienGiamGia"
    }
}
