//
//  CreateAppointmentRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/22/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

struct CreateAppointmentRequest: Codable {
    var idLichHen: Int?
    var tieuDe: String?
    var maKhachHang: String?
    var tenKhachHangDatHen: String?
    var ngaySinh: String?
    var maGioiTinh: Int?
    var maTinhThanh: String?
    var maQuanHuyen: String?
    var diaChi: String?
    var soDienThoai: String?
    var email: String?
    var batDau: String?
    var ghiChu: String?
    var soLuongKhach: Int?
    var listMaDichVuYeuCau: String?
    var listMaNhanVienYeuCau: String?
    var idPhongDichVu: Int?
    var idNguonDen: Int?
    var idNguonGioiThieu: Int?
    var trangThai: Int?
    var khachHangID: Int?
    var thoigian: [String] = ["",""]
    var idComboGoiDVSP: Int?
    var maLoaiDichVu: String?
    var tinhTrangHienTai: String?
    var tienSuBenhLyBanThan: String?
    var tienSuBenhLyGiaDinh: String?
    var nhipTim: String?
    var nhietDo: String?
    var huyetAp: String?

    enum CodingKeys: String, CodingKey {
        case idLichHen = "IDLichHen"
        case tieuDe = "TieuDe"
        case maKhachHang = "MaKhachHang"
        case tenKhachHangDatHen = "TenKhachHangDatHen"
        case ngaySinh = "NgaySinh"
        case maGioiTinh = "MaGioiTinh"
        case maTinhThanh = "MaTinhThanh"
        case maQuanHuyen = "MaQuanHuyen"
        case diaChi = "DiaChi"
        case soDienThoai = "SoDienThoai"
        case email = "Email"
        case batDau = "BatDau"
        case ghiChu = "GhiChu"
        case soLuongKhach = "SoLuongKhach"
        case listMaDichVuYeuCau = "ListMaDichVuYeuCau"
        case listMaNhanVienYeuCau = "ListMaNhanVienYeuCau"
        case idPhongDichVu = "IDPhongDichVu"
        case idNguonDen = "IdNguonDen"
        case idNguonGioiThieu = "IDNguonGioiThieu"
        case trangThai = "TrangThai"
        case khachHangID = "KhachHangID"
        case idComboGoiDVSP = "IDComboGoiDVSP"
        case maLoaiDichVu = "MaLoaiDichVu"
        case tinhTrangHienTai = "TinhTrangHienTai"
        case tienSuBenhLyBanThan = "TienSuBenhLyBanThan"
        case tienSuBenhLyGiaDinh = "TienSuBenhLyGiaDinh"
        case nhipTim = "NhipTim"
        case nhietDo = "NhietDo"
        case huyetAp = "HuyetAp"
    }
}
