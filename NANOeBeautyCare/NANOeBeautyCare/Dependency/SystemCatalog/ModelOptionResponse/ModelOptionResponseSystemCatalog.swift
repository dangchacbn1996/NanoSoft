//
//  ModelOptionResponseSystemCatalog.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/9/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
// MARK: - ModelOptionResponseSystemCatalog
struct ModelOptionResponseSystemCatalog: Codable {
    var code: Int?
    var msg: String?
    var data: [ModelOptionResponseSystemCatalogDatum]?
    var data1: [ModelOptionResponseSystemCatalogData1]?
    var data2: [ModelOptionResponseSystemCatalogData2]?
    var data3: [ModelOptionResponseSystemCatalogData3]?
    var data4: [ModelOptionResponseSystemCatalogData4]?
    var data5: [ModelOptionResponseSystemCatalogData5]?
    var data6: [ModelOptionResponseSystemCatalogData6]?
    var data7: [ModelOptionResponseSystemCatalogData7]?
    var data8: [ModelOptionResponseSystemCatalogData8]?
    var data9: [ModelOptionResponseSystemCatalogData9]?
    var data10: [ModelOptionResponseSystemCatalogData10]?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case data = "data"
        case data1 = "data1"
        case data2 = "data2"
        case data3 = "data3"
        case data4 = "data4"
        case data5 = "data5"
        case data6 = "data6"
        case data7 = "data7"
        case data8 = "data8"
        case data9 = "data9"
        case data10 = "data10"
    }
}

// MARK: - Datum
struct ModelOptionResponseSystemCatalogDatum: Codable {
    var id: Int?
    var tenGioiTinh: String?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case tenGioiTinh = "TenGioiTinh"
    }
}

// MARK: - Data1
struct ModelOptionResponseSystemCatalogData1: Codable {
    var id: Int?
    var maTinhThanh: String?
    var tenTinhThanh: String?
    var tenTiengAnh: String?
    var cap: String?
    var maQuocGia: String?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case maTinhThanh = "MaTinhThanh"
        case tenTinhThanh = "TenTinhThanh"
        case tenTiengAnh = "TenTiengAnh"
        case cap = "Cap"
        case maQuocGia = "MaQuocGia"
    }
}

// MARK: - Data10
struct ModelOptionResponseSystemCatalogData10: Codable {
    var id: Int?
    var idPhongBan: Int?
    var tenPhongBan: String?
    var diaChi: String?
    var soDienThoai: String?
    var thuTu: Int?
    var allID: String?
    var maCongTy: String?
    var fax: String?
    var email: String?
    var logo: String?
    var website: String?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case idPhongBan = "IDPhongBan"
        case tenPhongBan = "TenPhongBan"
        case diaChi = "DiaChi"
        case soDienThoai = "SoDienThoai"
        case thuTu = "ThuTu"
        case allID = "AllID"
        case maCongTy = "MaCongTy"
        case fax = "Fax"
        case email = "Email"
        case logo = "Logo"
        case website = "Website"
    }
}

// MARK: - Data2
struct ModelOptionResponseSystemCatalogData2: Codable {
    var idNhanVien: Int?
    var tenNhanVien: String?
    var anhNhanVien: String?
    var moTa: String?
    var idNhomNhanVien: Int?
    var idPhongBan: Int?
    var allID: String?
    var thuTu: Int?
    var nhomNhanVien: String?
    var tenPhongBan: String?

    enum CodingKeys: String, CodingKey {
        case idNhanVien = "IDNhanVien"
        case tenNhanVien = "TenNhanVien"
        case anhNhanVien = "AnhNhanVien"
        case moTa = "MoTa"
        case idNhomNhanVien = "IDNhomNhanVien"
        case idPhongBan = "IDPhongBan"
        case allID = "AllID"
        case thuTu = "ThuTu"
        case nhomNhanVien = "NhomNhanVien"
        case tenPhongBan = "TenPhongBan"
    }
}

// MARK: - Data3
struct ModelOptionResponseSystemCatalogData3: Codable {
    var idPhongDichVu: Int?
    var tenPhongDichVu: String?
    var diaChi: String?
    var soGiuongDichVu: Int?
    var anh: String?
    var idPhongBan: Int?
    var allID: String?
    var tenPhongBan: String?
    var maPhongDV: JSONNull?

    enum CodingKeys: String, CodingKey {
        case idPhongDichVu = "IDPhongDichVu"
        case tenPhongDichVu = "TenPhongDichVu"
        case diaChi = "DiaChi"
        case soGiuongDichVu = "SoGiuongDichVu"
        case anh = "Anh"
        case idPhongBan = "IDPhongBan"
        case allID = "AllID"
        case tenPhongBan = "TenPhongBan"
        case maPhongDV = "MaPhongDV"
    }
}

// MARK: - Data4
struct ModelOptionResponseSystemCatalogData4: Codable {
    var idNgheNghiep: Int?
    var tenNgheNghiep: String?
    var trangThaiSuDung: Bool?
    var maAnhXa: String?

    enum CodingKeys: String, CodingKey {
        case idNgheNghiep = "IDNgheNghiep"
        case tenNgheNghiep = "TenNgheNghiep"
        case trangThaiSuDung = "TrangThaiSuDung"
        case maAnhXa = "MaAnhXa"
    }
}

// MARK: - Data5
struct ModelOptionResponseSystemCatalogData5: Codable {
    var idNguonDen: Int?
    var tenNguonDen: String?
    var trangThaiSuDung: Bool?
    var maAnhXa: String?

    enum CodingKeys: String, CodingKey {
        case idNguonDen = "IDNguonDen"
        case tenNguonDen = "TenNguonDen"
        case trangThaiSuDung = "TrangThaiSuDung"
        case maAnhXa = "MaAnhXa"
    }
}

// MARK: - Data6
struct ModelOptionResponseSystemCatalogData6: Codable {
    var idNguonGioiThieu: Int?
    var nguonGioiThieu: String?
    var soDienThoai: String?
    var idPhongBan: Int?

    enum CodingKeys: String, CodingKey {
        case idNguonGioiThieu = "IDNguonGioiThieu"
        case nguonGioiThieu = "NguonGioiThieu"
        case soDienThoai = "SoDienThoai"
        case idPhongBan = "IDPhongBan"
    }
}

// MARK: - Data7
struct ModelOptionResponseSystemCatalogData7: Codable {
    var idLoaiKH: Int?
    var loaiKhachHang: String?
    var trangThaiSuDung: Bool?
    var phongBanID: Int?
    var congTyID: JSONNull?

    enum CodingKeys: String, CodingKey {
        case idLoaiKH = "IDLoaiKH"
        case loaiKhachHang = "LoaiKhachHang"
        case trangThaiSuDung = "TrangThaiSuDung"
        case phongBanID = "PhongBanID"
        case congTyID = "CongTyID"
    }
}

// MARK: - Data8
struct ModelOptionResponseSystemCatalogData8: Codable {
    var idNhomChuDe: Int?
    var tenNhomChuDe: String?
    var trangThaiSuDung: Bool?
    var idPhongBan: Int?

    enum CodingKeys: String, CodingKey {
        case idNhomChuDe = "IDNhomChuDe"
        case tenNhomChuDe = "TenNhomChuDe"
        case trangThaiSuDung = "TrangThaiSuDung"
        case idPhongBan = "IDPhongBan"
    }
}

// MARK: - Data9
struct ModelOptionResponseSystemCatalogData9: Codable {
}
