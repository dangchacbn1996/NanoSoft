//
//  CreateAppointmentOptionalResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/22/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

struct CreateAppointmentOptionalResponse: Codable {
    var code: Int?
    var msg: String?
    var idLichHen: Int?
    var maLichHen: String?
    var tieuDe: String?
    var maKhachHang: String?
    var tenKhachHangDatHen: String?
    var ngaySinh: String?
    var maGioiTinh: String?
    var maTinhThanh: String?
    var maQuanHuyen: String?
    var maXa: String?
    var diaChi: String?
    var soDienThoai: String?
    var email: String?
    var batDau: String?
    var ketThuc: String?
    var ghiChu: String?
    var soLuongKhach: Int?
    var listMaDichVuYeuCau: String?
    var listMaNhanVienYeuCau: String?
    var idPhongDichVu: Int?
    var idNguonDen: Int?
    var idNguonGioiThieu: Int?
    var trangThai: Int?
    var nguoiDungID: Int?
    var idPhongBan: Int?
    var congTyID: Int?
    var sysdate: String?
    var dateModified: String?
    var isSendSMS: Bool?
    var isSendMail: Bool?
    var isHoSo: Bool?
    var maHoSoLichHen: String?
    var khachHangID: Int?
    var stt: String?
    var isViewAdmin: Bool?
    var isViewUser: Bool?
    var idGioiTinh: String?
    var idPhanLoaiLichHen: String?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case idLichHen = "IDLichHen"
        case maLichHen = "MaLichHen"
        case tieuDe = "TieuDe"
        case maKhachHang = "MaKhachHang"
        case tenKhachHangDatHen = "TenKhachHangDatHen"
        case ngaySinh = "NgaySinh"
        case maGioiTinh = "MaGioiTinh"
        case maTinhThanh = "MaTinhThanh"
        case maQuanHuyen = "MaQuanHuyen"
        case maXa = "MaXa"
        case diaChi = "DiaChi"
        case soDienThoai = "SoDienThoai"
        case email = "Email"
        case batDau = "BatDau"
        case ketThuc = "KetThuc"
        case ghiChu = "GhiChu"
        case soLuongKhach = "SoLuongKhach"
        case listMaDichVuYeuCau = "ListMaDichVuYeuCau"
        case listMaNhanVienYeuCau = "ListMaNhanVienYeuCau"
        case idPhongDichVu = "IDPhongDichVu"
        case idNguonDen = "IdNguonDen"
        case idNguonGioiThieu = "IDNguonGioiThieu"
        case trangThai = "TrangThai"
        case nguoiDungID = "NguoiDungID"
        case idPhongBan = "IDPhongBan"
        case congTyID = "CongTyID"
        case sysdate = "Sysdate"
        case dateModified = "DateModified"
        case isSendSMS = "IsSendSMS"
        case isSendMail = "IsSendMail"
        case isHoSo = "IsHoSo"
        case maHoSoLichHen = "MaHoSoLichHen"
        case khachHangID = "KhachHangID"
        case stt = "STT"
        case isViewAdmin = "IsViewAdmin"
        case isViewUser = "IsViewUser"
        case idGioiTinh = "IDGioiTinh"
        case idPhanLoaiLichHen = "IDPhanLoaiLichHen"
    }
}
