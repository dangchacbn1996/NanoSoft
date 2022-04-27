//
//  CustomerDetailOptionalResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/9/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

// MARK: - DataClass
struct CustomerDetailOptionalResponse: Codable {
    var code: Int?
    var msg: String?
    var id: Int?
    var soLuongLichHen: Int?
    var choPhucVu: Int?
    var huyLichHen: Int?
    var srcImage: String?
    var urlLink: String?
    var maKhachHang: String?
    var maChiNhanh: String?
    var hoTen: String?
    var ngaySinh: String?
    var maGioiTinh: String?
    var dienThoai: String?
    var diaChi: String?
    var maTinhThanh: String?
    var idLoaiKH: Int?
    var maQuanHuyen: String?
    var idNgheNghiep: Int?
    var idNguonDen: Int?
    var idNguonGioiThieu: Int?
    var email: String?
    var faceBook: String?
    var congTy: String?
    var ghiChu: String?
    var ngayTao: String?
    var ngayCapNhat: String?
    var ngayDen: String?
    var anhKhachHang: String?
    var stt: Int?
    var phongBanID: Int?
    var congTyID: Int?
    var tenGioiTinh: String?
    var idPhongBan: Int?
    var tenPhongBan: String?
    var maPhongBan: String?
    var isPhongBan: Bool?
    var isChiNhanh: Bool?
    var maCongTy: String?
    var isCongTy: Bool?
    var allID: String?
    var tenQuanHuyen: String?
    var loaiKhachHang: String?
    var tenNgheNghiep: String?
    var tongDiemTichLuy: Int?
    var tenHangThanhVien: String?
    var mocDiemDat: Int?
    var tenTinhThanh: String?
    var idGioiTinh: Int?
    var idXepHangThanhVien: Int?
    var tongDiemTichLuyDaDung: Int?
    var soTienChiTieu: Int64?
    var idPhanHangKhachHang: String?
    var soDiDong: String?
    var chiNhanhID: Int?
    var nguoiTaoID: Int?
    var tenNguonDen: String?
    var nguonGioiThieu: String?
    var IsNhacLichThongBao: Bool?
    var GioNhacLich: String?


    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case id = "ID"
        case soLuongLichHen = "SoLuongLichHen"
        case choPhucVu = "ChoPhucVu"
        case huyLichHen = "HuyLichHen"
        case srcImage = "srcImage"
        case urlLink = "URL_LINK"
        case maKhachHang = "MaKhachHang"
        case maChiNhanh = "MaChiNhanh"
        case hoTen = "HoTen"
        case ngaySinh = "NgaySinh"
        case maGioiTinh = "MaGioiTinh"
        case dienThoai = "DienThoai"
        case diaChi = "DiaChi"
        case maTinhThanh = "MaTinhThanh"
        case idLoaiKH = "IDLoaiKH"
        case maQuanHuyen = "MaQuanHuyen"
        case idNgheNghiep = "IDNgheNghiep"
        case idNguonDen = "IDNguonDen"
        case idNguonGioiThieu = "IDNguonGioiThieu"
        case email = "Email"
        case faceBook = "FaceBook"
        case congTy = "CongTy"
        case ghiChu = "GhiChu"
        case ngayTao = "NgayTao"
        case ngayCapNhat = "NgayCapNhat"
        case ngayDen = "NgayDen"
        case anhKhachHang = "AnhKhachHang"
        case stt = "STT"
        case phongBanID = "PhongBanID"
        case congTyID = "CongTyID"
        case tenGioiTinh = "TenGioiTinh"
        case idPhongBan = "IDPhongBan"
        case tenPhongBan = "TenPhongBan"
        case maPhongBan = "MaPhongBan"
        case isPhongBan = "IsPhongBan"
        case isChiNhanh = "IsChiNhanh"
        case maCongTy = "MaCongTy"
        case isCongTy = "IsCongTy"
        case allID = "AllID"
        case tenQuanHuyen = "TenQuanHuyen"
        case loaiKhachHang = "LoaiKhachHang"
        case tenNgheNghiep = "TenNgheNghiep"
        case tongDiemTichLuy = "TongDiemTichLuy"
        case tenHangThanhVien = "TenHangThanhVien"
        case mocDiemDat = "MocDiemDat"
        case tenTinhThanh = "TenTinhThanh"
        case idGioiTinh = "IdGioiTinh"
        case idXepHangThanhVien = "IDXepHangThanhVien"
        case tongDiemTichLuyDaDung = "TongDiemTichLuyDaDung"
        case soTienChiTieu = "SoTienChiTieu"
        case idPhanHangKhachHang = "IDPhanHangKhachHang"
        case soDiDong = "SoDiDong"
        case chiNhanhID = "ChiNhanhID"
        case nguoiTaoID = "NguoiTaoID"
        case tenNguonDen = "TenNguonDen"
        case nguonGioiThieu = "NguonGioiThieu"
        case IsNhacLichThongBao = "IsNhacLichThongBao"
        case GioNhacLich = "GioNhacLich"
    }
}
