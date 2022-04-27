//
//  CustomerSearchRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/23/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - CustomerSearchRequest
struct CustomerSearchRequest: Codable {
    var denNgay: String?
    var idLoaiKH: Int = 0
    var idNgheNghiep: Int = 0
    var idNguonDen: Int = 0
    var idNguonGioiThieu: Int = 0
    var idXepHangThanhVien: Int = 0
    var keyWord: String = ""
    var pageNum: Int?
    var pageSize: Int?
    var searhIn: String = "MaKhachHang,HoTen,DienThoai,DiaChi,Email"
    var tuNgay: String?

    enum CodingKeys: String, CodingKey {
        case denNgay = "DenNgay"
        case idLoaiKH = "IDLoaiKH"
        case idNgheNghiep = "IDNgheNghiep"
        case idNguonDen = "IDNguonDen"
        case idNguonGioiThieu = "IDNguonGioiThieu"
        case idXepHangThanhVien = "IDXepHangThanhVien"
        case keyWord = "KeyWord"
        case pageNum = "page_num"
        case pageSize = "page_size"
        case searhIn = "SearhIn"
        case tuNgay = "TuNgay"
    }
}
