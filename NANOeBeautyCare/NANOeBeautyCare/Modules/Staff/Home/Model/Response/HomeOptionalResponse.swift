//
//  HomeOptionalResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/8/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

// MARK: - HomeOptionalResponse
struct HomeOptionalResponse: Codable {
    var totalRow: Int?
    var id: Int?
    var maKhachHang: String?
    var maChiNhanh: String?
    var hoTen: String?
    var ngaySinh: String?
    var dienThoai: String?
    var diaChi: String?
    var maTinhThanh: String?
    var idLoaiKH: Int?
    var maQuanHuyen: String?
    var idNgheNghiep: Int?
    var idNguonDen: Int?
    var idNguonGioiThieu: IDNguonGioiThieu?
    var email: String?
    var faceBook: String?
    var congTy: String?
    var ghiChu: String?
    var ngayTao: String?
    var ngayDen: String?
    var anhKhachHang: String?
    var phongBanID: Int?
    var tenGioiTinh: String?
    var tenPhongBan: String?
    var maPhongBan: String?
    var allID: String?
    var tenQuanHuyen: String?
    var loaiKhachHang: String?
    var tenNgheNghiep: String?
    var tongDiemTichLuy: Int?
    var tenHangThanhVien: String?
    var mocDiemDat: IDNguonGioiThieu?
    var tenTinhThanh: String?
    var idGioiTinh: IDNguonGioiThieu?
    var idXepHangThanhVien: IDNguonGioiThieu?
    var tongDiemTichLuyDaDung: IDNguonGioiThieu?
    var ngayCapNhat: String?

    enum CodingKeys: String, CodingKey {
        case totalRow = "TotalRow"
        case id = "ID"
        case maKhachHang = "MaKhachHang"
        case maChiNhanh = "MaChiNhanh"
        case hoTen = "HoTen"
        case ngaySinh = "NgaySinh"
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
        case ngayDen = "NgayDen"
        case anhKhachHang = "AnhKhachHang"
        case phongBanID = "PhongBanID"
        case tenGioiTinh = "TenGioiTinh"
        case tenPhongBan = "TenPhongBan"
        case maPhongBan = "MaPhongBan"
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
        case ngayCapNhat = "NgayCapNhat"
    }
}

enum IDNguonGioiThieu: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(IDNguonGioiThieu.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for IDNguonGioiThieu"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
