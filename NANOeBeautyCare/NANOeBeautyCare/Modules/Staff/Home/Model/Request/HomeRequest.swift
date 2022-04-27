//
//  HomeRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/8/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

// MARK: - DataClass
struct HomeRequest: Codable {
    var idLoaiKH: Int = 0
    var idNgheNghiep: Int = 0
    var idNguonDen: Int = 0
    var idNguonGioiThieu: Int = 0
    var idXepHangThanhVien: Int = 0
    var keyWord: String = ""
    var searhIn: String = "MaKhachHang,HoTen,DienThoai,DiaChi,Email"
    var tuNgay: String = Date().startDateOfMonth.getFormattedDate(format: "dd/MM/yyyy")
    var denNgay: String = Date().endDateOfMonth.getFormattedDate(format: "dd/MM/yyyy")
    var pageSize: Int = Int(kDefaultPageSize)
    var pageNum: Int = Int(kDefaultStartPage)

    enum CodingKeys: String, CodingKey {
        case idLoaiKH = "IDLoaiKH"
        case idNgheNghiep = "IDNgheNghiep"
        case idNguonDen = "IDNguonDen"
        case idNguonGioiThieu = "IDNguonGioiThieu"
        case idXepHangThanhVien = "IDXepHangThanhVien"
        case keyWord = "KeyWord"
        case searhIn = "SearhIn"
        case tuNgay = "TuNgay"
        case denNgay = "DenNgay"
        case pageSize = "page_size"
        case pageNum = "page_num"
    }
}
