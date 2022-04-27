//
//  CreateSaleServiceResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/30/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

// MARK: - CreateSaleServiceResponse
struct CreateSaleServiceResponse: Codable {
    var code: Int?
    var msg: String?
    var msgCode: String?
    var hoso: CreateSaleServiceDataClass?
    var data: CreateSaleServiceDataClass?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case msgCode = "msg_code"
        case hoso = "hoso"
        case data = "data"
    }
}

// MARK: - DataClass
struct CreateSaleServiceDataClass: Codable {
    var idHoSo: Int?
    var maHoSo: String?
    var idPhongBan: Int?
    var maKhachHang: String?
    var ngayDen: String?
    var trangThai: Int?
    var nguoiDungId: Int?
    var ngayCapNhat: String?
    var tongTien: Double?
    var tongTienGiamGiaHd: Double?
    var tongTienThanhToan: Double?
    var idLichHen: Int?
    var bSuDungGoi: Bool?
    var khachHangId: Int?
    var stt: Int?
    var thongTinKhac: String?
    var phongTuVanId: String?
    var trangThaiTuVan: String?
    var idTrangThaiThucHienDv: String?
    var ghiChu: String?
    var tongTienGiamGiaDvSpThe: Double?
    var idChuongTrinhKm: String?
    var lyDoGiamGia: String?

    enum CodingKeys: String, CodingKey {
        case idHoSo = "IDHoSo"
        case maHoSo = "MaHoSo"
        case idPhongBan = "IDPhongBan"
        case maKhachHang = "MaKhachHang"
        case ngayDen = "NgayDen"
        case trangThai = "TrangThai"
        case nguoiDungId = "NguoiDungID"
        case ngayCapNhat = "NgayCapNhat"
        case tongTien = "TongTien"
        case tongTienGiamGiaHd = "TongTienGiamGiaHD"
        case tongTienThanhToan = "TongTienThanhToan"
        case idLichHen = "IDLichHen"
        case bSuDungGoi = "bSuDungGoi"
        case khachHangId = "KhachHangID"
        case stt = "STT"
        case thongTinKhac = "ThongTinKhac"
        case phongTuVanId = "PhongTuVanID"
        case trangThaiTuVan = "TrangThaiTuVan"
        case idTrangThaiThucHienDv = "IDTrangThaiThucHienDV"
        case ghiChu = "GhiChu"
        case tongTienGiamGiaDvSpThe = "TongTienGiamGia_DV_SP_THE"
        case idChuongTrinhKm = "IDChuongTrinhKM"
        case lyDoGiamGia = "LyDoGiamGia"
    }
}
