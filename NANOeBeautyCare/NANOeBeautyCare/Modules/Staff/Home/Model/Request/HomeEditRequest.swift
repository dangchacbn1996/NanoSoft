//
//  HomeEditRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/10/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - HomeEditRequest
struct HomeEditRequest: Codable {
    var user: String?
    var sid: String?
    var group: String?
    var action: String?
    var cmd: String?
    var data: HomeEditRequestDataClass?
    var checksum: String?

    enum CodingKeys: String, CodingKey {
        case user = "user"
        case sid = "sid"
        case group = "group"
        case action = "action"
        case cmd = "cmd"
        case data = "data"
        case checksum = "checksum"
    }
}

// MARK: - DataClass
struct HomeEditRequestDataClass: Codable {
    var id: Int?
    var maKhachHang: String?
    var maChiNhanh: String?
    var hoTen: String?
    var ngaySinh: String?
    var maGioiTinh: Int?
    var dienThoai: String?
    var diaChi: String?
    var maTinhThanh: String?
    var maQuanHuyen: String?
    var idLoaiKH: Int?
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
    var idGioiTinh: Int?
    var soDiDong: String?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case maKhachHang = "MaKhachHang"
        case maChiNhanh = "MaChiNhanh"
        case hoTen = "HoTen"
        case ngaySinh = "NgaySinh"
        case maGioiTinh = "MaGioiTinh"
        case dienThoai = "DienThoai"
        case diaChi = "DiaChi"
        case maTinhThanh = "MaTinhThanh"
        case maQuanHuyen = "MaQuanHuyen"
        case idLoaiKH = "IDLoaiKH"
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
        case idGioiTinh = "IdGioiTinh"
        case soDiDong = "SoDiDong"
    }
}
