//
//  SearchCustomerAppointmentOptionalResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/27/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - SearchCustomerAppointmentOptionalResponseElement
struct SearchCustomerAppointmentOptionalResponse: Codable {
    var hoTen: String?
    var id: Int?
    var dienThoai: String?
    var diaChi: String?
    var email: String?
    var ngaySinh: String?
    var maTinhThanh: String?
    var maQuanHuyen: String?
    var idLoaiKH: Int?
    var idNgheNghiep: Int?
    var ngayDen: String = ""
    var maHoSo: String = ""
    var trangThaiSwipe: Int = 0
    var trangThaiSwipeText: String = ""
    var anhKhachHang: String = ""

    enum CodingKeys: String, CodingKey {
        case hoTen = "HoTen"
        case id = "ID"
        case dienThoai = "DienThoai"
        case diaChi = "DiaChi"
        case email = "Email"
        case ngaySinh = "NgaySinh"
        case maTinhThanh = "MaTinhThanh"
        case maQuanHuyen = "MaQuanHuyen"
        case idLoaiKH = "IDLoaiKH"
        case idNgheNghiep = "IDNgheNghiep"
    }
}
