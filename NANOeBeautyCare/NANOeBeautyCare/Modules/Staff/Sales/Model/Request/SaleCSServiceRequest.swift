//
//  SaleCSServiceRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/20/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
// MARK: - SaleCsServiceRequest
struct SaleCsServiceRequest: Codable {
    var bSuDungGoi: Bool = false
    var ghiChu: String = ""
    var hoTen: String = ""
    var idHoSo: Int = 0
    var khachHangId: Int = 0
    var lstGiamGiaHoSoKhachHang: [LstsssGiamGiaHoSoKhachHang] = []
    var lstSanPhamDichVuThe: [LstsssSanPhamDichVuThe] = []
    var maHoSo: String = ""
    var maKhachHang: String = ""
    var ngayDen: String = ""
    var stt: Int = 0
    var tongTien: Double = 0.0
    var tongTienGiamGiaDvSpThe: Double = 0.0
    var tongTienGiamGiaHd: Double = 0.0
    var tongTienThanhToan: Double = 0.0

    enum CodingKeys: String, CodingKey {
        case bSuDungGoi = "bSuDungGoi"
        case ghiChu = "GhiChu"
        case hoTen = "HoTen"
        case idHoSo = "IDHoSo"
        case khachHangId = "KhachHangID"
        case lstGiamGiaHoSoKhachHang = "lstGiamGiaHoSoKhachHang"
        case lstSanPhamDichVuThe = "lstSanPhamDichVuThe"
        case maHoSo = "MaHoSo"
        case maKhachHang = "MaKhachHang"
        case ngayDen = "NgayDen"
        case stt = "STT"
        case tongTien = "TongTien"
        case tongTienGiamGiaDvSpThe = "TongTienGiamGia_DV_SP_THE"
        case tongTienGiamGiaHd = "TongTienGiamGiaHD"
        case tongTienThanhToan = "TongTienThanhToan"
    }
}

// MARK: - LstsssGiamGiaHoSoKhachHang
struct LstsssGiamGiaHoSoKhachHang: Codable {
    var giamGia: Double = 0.0
    var htGiamGia: Int = 0
    var maGiamGia: String = ""
    var thanhTienGiamGia: Double = 0.0

    enum CodingKeys: String, CodingKey {
        case giamGia = "GiamGia"
        case htGiamGia = "HTGiamGia"
        case maGiamGia = "MaGiamGia"
        case thanhTienGiamGia = "ThanhTienGiamGia"
    }
}

// MARK: - LstsssSanPhamDichVuThe
struct LstsssSanPhamDichVuThe: Codable {
    var donGia: Double = 0.0
    var donvi: Int = 0
    var giamGia: Double = 0.0
    var htGiamGia: Double = 0.0
    var htTraHoaHong: Double = 0.0
    var idChuongTrinhKm: Int = 0
    var idNguonGioiThieu: Int = 0
    var id: Int = 0
    var idCt: Int = 0
    var listIdTuVanVien: String = ""
    var maGiamGia: String = ""
    var maGiamGiaTien: Double = 0.0
    var nguonGioiThieuSoDienThoai: String = ""
    var nguonGioiThieuTen: String = ""
    var soLuong: Double = 0.0
    var thanhTien: Double = 0.0
    var thanhTienGiamGia: Double = 0.0
    var thanhTienThanhToan: Double = 0.0
    var tienGiam: Double = 0.0
    var tienHoaHong: Double = 0.0
    var trangThai: Int = 0
    var type: String = ""

    enum CodingKeys: String, CodingKey {
        case donGia = "DonGia"
        case donvi = "donvi"
        case giamGia = "GiamGia"
        case htGiamGia = "HTGiamGia"
        case htTraHoaHong = "HTTraHoaHong"
        case idChuongTrinhKm = "IDChuongTrinhKM"
        case idNguonGioiThieu = "IDNguonGioiThieu"
        case id = "id"
        case idCt = "idCT"
        case listIdTuVanVien = "ListIDTuVanVien"
        case maGiamGia = "MaGiamGia"
        case maGiamGiaTien = "MaGiamGia_Tien"
        case nguonGioiThieuSoDienThoai = "nguonGioiThieu_SoDienThoai"
        case nguonGioiThieuTen = "nguonGioiThieu_Ten"
        case soLuong = "SoLuong"
        case thanhTien = "ThanhTien"
        case thanhTienGiamGia = "ThanhTienGiamGia"
        case thanhTienThanhToan = "ThanhTienThanhToan"
        case tienGiam = "TienGiam"
        case tienHoaHong = "TienHoaHong"
        case trangThai = "TrangThai"
        case type = "type"
    }
}
