//
//  CustomerSignUpRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 22/01/2021
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

struct CustomerSignUpRequest: Codable {
    var hoTen: String?
    var ngaySinh: String?
    var idGioiTinh: Int?
    var dienThoai: String?
    var maQuanHuyen: String?
    var maTinhThanh: String?
    var diaChi: String?
    var email: String?
    var idLoaiKh: Int?
    var idNgheNghiep: Int?
    var idNguonDen: Int?
    var idNguonGioiThieu: Int?
    var faceBook: String?
    var ghiChu: String?
    var anhKhachHang: String?
    var soCmndTheCccd: String?
    var mucDichDen: String?
    var hoChieu: String?
    var linkFaceHoiThoai: String?
    var maCongTy: String = Common.BRAND_NUMBER
    var matKhau: String?
    var congTy: String?

    enum CodingKeys: String, CodingKey {
        case hoTen = "HoTen"
        case ngaySinh = "NgaySinh"
        case idGioiTinh = "IdGioiTinh"
        case dienThoai = "DienThoai"
        case maQuanHuyen = "MaQuanHuyen"
        case maTinhThanh = "MaTinhThanh"
        case diaChi = "DiaChi"
        case email = "Email"
        case idLoaiKh = "IDLoaiKH"
        case idNgheNghiep = "IDNgheNghiep"
        case idNguonDen = "IDNguonDen"
        case idNguonGioiThieu = "IDNguonGioiThieu"
        case faceBook = "FaceBook"
        case ghiChu = "GhiChu"
        case anhKhachHang = "AnhKhachHang"
        case soCmndTheCccd = "SoCMND_TheCCCD"
        case mucDichDen = "MucDichDen"
        case hoChieu = "HoChieu"
        case linkFaceHoiThoai = "LinkFaceHoiThoai"
        case maCongTy = "MaCongTy"
        case matKhau = "MatKhau"
        case congTy = "CongTy"
    }
}
