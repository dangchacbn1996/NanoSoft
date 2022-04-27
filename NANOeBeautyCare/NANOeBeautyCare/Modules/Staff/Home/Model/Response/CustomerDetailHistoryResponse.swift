//
//  CustomerDetailHistoryResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/20/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

// MARK: - CustomerDetailHistoryResponseElement
struct CustomerDetailHistoryResponseElement: Codable {
    var maHoSo: String?
    var idHoSo: Int?
    var maKhachHang: String?
    var khachHangID: Int?
    var idPhongBan: Int?
    var ngayDen: String?
    var tongTienThanhToan: Double?
    var giamGia: Int?
    var tenDichVuSanPhamThe: String?
    var linkWeb: String?

    enum CodingKeys: String, CodingKey {
        case maHoSo = "MaHoSo"
        case idHoSo = "IDHoSo"
        case maKhachHang = "MaKhachHang"
        case khachHangID = "KhachHangID"
        case idPhongBan = "IDPhongBan"
        case ngayDen = "NgayDen"
        case tongTienThanhToan = "TongTienThanhToan"
        case giamGia = "GiamGia"
        case tenDichVuSanPhamThe = "TenDichVuSanPhamThe"
        case linkWeb = "Link_Web"
    }
}
