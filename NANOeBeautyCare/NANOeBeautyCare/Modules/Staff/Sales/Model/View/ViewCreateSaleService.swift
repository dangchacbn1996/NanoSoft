//
//  ViewCreateSaleService.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/30/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

// MARK: - ViewCreateSaleService
class ViewCreateSaleService: Codable {
    var header: Customer?
    var customer: SearchCustomerAppointmentOptionalResponse?
    var listService: ListService?
    var footer: FooterService?

    enum CodingKeys: String, CodingKey {
        case header = "header"
        case customer = "customer"
        case listService = "listService"
        case footer = "footer"
    }

    init(header: Customer?, customer: SearchCustomerAppointmentOptionalResponse?, listService: ListService?, footer: FooterService?) {
        self.header = header
        self.customer = customer
        self.listService = listService
        self.footer = footer
    }
}

// MARK: - Customer
class Customer: Codable {

    init() {
    }
}

// MARK: - FooterService
class FooterService: Codable {
    var ghiChu: String?
    var tongTienGiamGiaHD: Double?
    var tongTienThanhToan: Double?
    var tongTien: Double?
    var tongTienGiamGiaDVSPTHE: Double?

    var discountPromotion: Double = 0.0
    var discountPoint: Double = 0.0
    var discountSeria: Double = 0.0
    var trangthaiSwipe: Int = 0
    var lstGiamGiaHoSoKhachHang: [LstsssGiamGiaHoSoKhachHang] = []

    var promotion: PromotionProductOptionalResponse?
    var seria: SeriaDiscountOptionalResponse?
    var poitMember: PointMemberOptionalResponse?
    var poitMemberTransfer: TransferPointMemberOptionalResponse?
    
    var valueThanhTienGiamGia: Double = 0
    var typeThanhTienGiamGia: Bool = false

    // Khuyến mãi
    var discountSelected: Double = 0
    var discountInput: Double = 0
    var donGiaNew:Double = 0

    enum CodingKeys: String, CodingKey {
        case ghiChu = "GhiChu"
        case tongTienGiamGiaHD = "TongTienGiamGiaHD"
        case tongTienThanhToan = "TongTienThanhToan"
        case tongTien = "TongTien"
        case tongTienGiamGiaDVSPTHE = "TongTienGiamGia_DV_SP_THE"
        case discountPromotion = "discountPromotion"
        case discountPoint = "discountPoint"
        case discountSeria = "discountSeria"
        case trangthaiSwipe = "trangthaiSwipe"
        case lstGiamGiaHoSoKhachHang = "lstGiamGiaHoSoKhachHang"
        case promotion = "promotion"
        case seria  = "seria"
        case poitMember = "poitMember"
        
        case valueThanhTienGiamGia = "valueThanhTienGiamGia"
        case typeThanhTienGiamGia = "typeThanhTienGiamGia"
        case discountSelected = "discountSelected"
        case discountInput = "discountInput"
        case donGiaNew = "donGiaNew"
    }

    init(ghiChu: String?, tongTienGiamGiaHD: Double?, tongTienThanhToan: Double?, tongTien: Double?, tongTienGiamGiaDVSPTHE: Double?) {
        self.ghiChu = ghiChu
        self.tongTienGiamGiaHD = tongTienGiamGiaHD
        self.tongTienThanhToan = tongTienThanhToan
        self.tongTien = tongTien
        self.tongTienGiamGiaDVSPTHE = tongTienGiamGiaDVSPTHE
    }
}


// MARK: - Customer
class ListService: Codable {
    var rowID: Int?
    var loai: String?
    var id: Int?
    var ten: String?
    var soLuong: Double?
    var donGia: Double?
    var thanhTien: Double?
    var giamGia: Double?
    var thanhTienGiamGia: Double?
    var tienThanhToan: Double?
    var htGiamGia: Double?
    var anhDaiDien: String?
    var tenDonVi: String?
    var htTraHoaHong: Int?
    var maGiamGiaTien: Int?
    // Người giới thiệu
    var idNguonGioiThieu: Int?
    var listIDTuVanVien: String?
    var maGiamGia: String?
    var idCT: Int?
    var trangThai: Int?
    var listIDNhanVien: String?
    var sdtNguonGioiThieu: String?
    var hoaHongTraNVTuVan: Double?
    var maQuanLyDV: String?
    var nguonGioiThieu: String?
    var listTenNhanVienTuVan: String?
    var listTenNhanVien: String?
    var donGiaNew:Double = 0
    // NEW
    var tenNguonGioiThieu: String?
    var thanhTienThanhToan: Double?
    var tienGiam: Double?
    var tienHoaHong: Double?
    var donvi:Int?

    // Promotion
    var promotion: PromotionProductOptionalResponse?
    var valueThanhTienGiamGia: Double = 0
    var typeThanhTienGiamGia: Bool = false

    // Ref
    var sourceToRef: ModelOptionResponseSourceToCatalogDatum?
    // Discount
    var seriaDiscountTra: SeriaDiscountOptionalResponse?
    // Khuyến mãi
    var discountSelected: Double = 0
    var discountInput: Double = 0
    var discountSeria: Double = 0

    var trangthaiSwipe: Int = 0

    enum CodingKeys: String, CodingKey {
        case rowID = "RowID"
        case loai = "Loai"
        case id = "Id"
        case ten = "Ten"
        case soLuong = "SoLuong"
        case donGia = "DonGia"
        case thanhTien = "ThanhTien"
        case giamGia = "GiamGia"
        case thanhTienGiamGia = "ThanhTienGiamGia"
        case tienThanhToan = "TienThanhToan"
        case htGiamGia = "HTGiamGia"
        case anhDaiDien = "AnhDaiDien"
        case tenDonVi = "TenDonVi"
        case htTraHoaHong = "HTTraHoaHong"
        case maGiamGiaTien = "MaGiamGia_Tien"
        case idNguonGioiThieu = "IDNguonGioiThieu"
        case listIDTuVanVien = "ListIDTuVanVien"
        case maGiamGia = "MaGiamGia"
        case idCT = "idCT"
        case trangThai = "TrangThai"
        case listIDNhanVien = "ListIDNhanVien"
        case sdtNguonGioiThieu = "SDTNguonGioiThieu"
        case hoaHongTraNVTuVan = "HoaHongTraNVTuVan"
        case maQuanLyDV = "MaQuanLyDV"
        case nguonGioiThieu = "NguonGioiThieu"
        case listTenNhanVienTuVan = "ListTenNhanVienTuVan"
        case listTenNhanVien = "ListTenNhanVien"
        // New
        case tenNguonGioiThieu = "nguonGioiThieu_Ten"
        case thanhTienThanhToan = "ThanhTienThanhToan"
        case tienGiam = "TienGiam"
        case tienHoaHong = "tienHoaHong"
        case donvi = "donvi"

        //
        case promotion = "promotion"
        case valueThanhTienGiamGia = "valueThanhTienGiamGia"
        case typeThanhTienGiamGia = "typeThanhTienGiamGia"
        //
        case sourceToRef = "sourceToRef"
        //
        case seriaDiscountTra = "seriaDiscountTra"

        case discountSelected = "discountSelected"
        case discountInput = "discountInput"
        case discountSeria = "discountSeria"
        case trangthaiSwipe = "trangthaiSwipe"
    }
    init() {
        
    }

    init(rowID: Int?, loai: String?, id: Int?, ten: String?, soLuong: Double?, donGia: Double?, thanhTien: Double?, giamGia: Double?, thanhTienGiamGia: Double?, tienThanhToan: Double?, htGiamGia: Double?, anhDaiDien: String?, tenDonVi: String?, htTraHoaHong: Int?, maGiamGiaTien: Int?, idNguonGioiThieu: Int?, listIDTuVanVien: String?, maGiamGia: String?, idCT: Int?, trangThai: Int?, listIDNhanVien: String?, sdtNguonGioiThieu: String?, hoaHongTraNVTuVan: Double?, maQuanLyDV: String?, nguonGioiThieu: String?, listTenNhanVienTuVan: String?, listTenNhanVien: String?, tenNguonGioiThieu: String?, thanhTienThanhToan: Double?, tienGiam: Double?, tienHoaHong: Double?, donvi: Int?) {
        self.rowID = rowID
        self.loai = loai
        self.id = id
        self.ten = ten
        self.soLuong = soLuong
        self.donGia = donGia
        self.thanhTien = thanhTien
        self.giamGia = giamGia
        self.thanhTienGiamGia = thanhTienGiamGia
        self.tienThanhToan = tienThanhToan
        self.htGiamGia = htGiamGia
        self.anhDaiDien = anhDaiDien
        self.tenDonVi = tenDonVi
        self.htTraHoaHong = htTraHoaHong
        self.maGiamGiaTien = maGiamGiaTien
        self.idNguonGioiThieu = idNguonGioiThieu
        self.listIDTuVanVien = listIDTuVanVien
        self.maGiamGia = maGiamGia
        self.idCT = idCT
        self.trangThai = trangThai
        self.listIDNhanVien = listIDNhanVien
        self.sdtNguonGioiThieu = sdtNguonGioiThieu
        self.hoaHongTraNVTuVan = hoaHongTraNVTuVan
        self.maQuanLyDV = maQuanLyDV
        self.nguonGioiThieu = nguonGioiThieu
        self.listTenNhanVienTuVan = listTenNhanVienTuVan
        self.listTenNhanVien = listTenNhanVien
        self.tenNguonGioiThieu = tenNguonGioiThieu
        self.thanhTienThanhToan = thanhTienThanhToan
        self.tienGiam = tienGiam
        self.tienHoaHong = tienHoaHong
        self.donvi = donvi
    }
}


class ViewCreateSale: HeaderFooterModelProvider {
    typealias CellModelType = CellViewCreateSale
    typealias HeaderModelType = Any
    typealias FooterModelType = Any

    var headerProperty: (identifier: String?, height: CGFloat?, model: Any?)?
    var items: [CellViewCreateSale]?
    var footerProperty: (identifier: String?, height: CGFloat?, model: Any?)?

    required init(_ _header: (identifier: String?, height: CGFloat?, model: Any?)?, _ _footer: (identifier: String?, height: CGFloat?, model: Any?)?, _ _items: [CellViewCreateSale]?) {
        headerProperty = _header
        items = _items
        footerProperty = _footer
    }
}

struct CellViewCreateSale: CellModelProvider {
    typealias CellModelType = ViewCreateSaleService
    var property: (identifier: String, height: CGFloat?, model: ViewCreateSaleService?)?

    init(_ _property: (identifier: String, height: CGFloat?, model: ViewCreateSaleService?)?) {
        property = _property
    }
}
