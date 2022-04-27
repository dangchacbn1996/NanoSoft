//
//  ServiceSystemCatalog.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/9/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

extension BaseService {
    //    """API danh mục hành chính: lấy ID và tên, ảnh nếu có, loại. Dữ liệu được phân quyền theo chi nhánh
    //    danh mục tương ứng trả về
    //
    //    - giới tính  = data
    //    - tỉnh thành phố   = data1
    //    - nhân viên  = data2
    //    - phòng dịch vụ  = data3
    //    - nghề nghiệp  = data4
    //    - nguồn đến  = data5
    //    - nguồn giới thiệu  = data6
    //    - loại khách hàng  = data7
    //    - dm nhóm chủ đề cộng đồng  = data8
    //    - dm nhóm tin tức  = data9
    //    - danh mục các chi nhánh ( tên, địa chỉ,logo, điện thoại)""  = data10
    //
    //    "
    
    func systemCatalog(request:ModelRequestSystemCatalog = ModelRequestSystemCatalog(user: Common.BRAND_USER, sid: Common.BRAND_SID, group: "DanhMuc", action: "Index", cmd: "DanhMuc.HeThong", data: DataClass(), checksum: ""),callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        self.requestPOST(type: ModelOptionResponseSystemCatalog.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    
    //    Danh sách giới tính
    func systemGenderCatalog(request:ModelRequestSystemCatalog = ModelRequestSystemCatalog(user: Common.BRAND_USER, sid: Common.BRAND_SID, group: "DmGioiTinh", action: "Index", cmd: "DmGioiTinh.GetAll", data: DataClass(), checksum: ""),callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        self.requestPOST(type: ModelOptionResponseSystemGenderCatalog.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    //    Danh sách tỉnh thành
    func systemProvincesCatalog(request:ModelRequestSystemCatalog = ModelRequestSystemCatalog(user: Common.BRAND_USER, sid: Common.BRAND_SID, group: "DmTinhThanh", action: "Index", cmd: "DmTinhThanh.GetAll", data: DataClass(), checksum: ""),callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        self.requestPOST(type: ModelOptionResponseProvincesCatalog.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    //    Danh sách quận huyện theo mã tỉnh thảnh
    func systemDistrictsByProvinceCodeCatalog(maTinhThanh:String,callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = ModelRequestDistrictsByProvinceCodeCatalog(user: Common.BRAND_USER, sid: Common.BRAND_SID, group: "DmQuanHuyen", action: "Index", cmd: "DmQuanHuyen.GetByMaTinhThanh", data: ModelRequestDistrictsByProvinceCodeCatalogDataClass(maTinhThanh: maTinhThanh), checksum: "")
        self.requestPOST(type: ModelOptionResponseDistrictsByProvinceCodeCatalog.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    
    func systemDistrictsByProvinceCodeCatalog(maTinhThanh:String, failed: @escaping (Int?, String?) -> Void, success: @escaping (ModelOptionResponseDistrictsByProvinceCodeCatalog) -> Void) {
        let request = ModelRequestDistrictsByProvinceCodeCatalog(user: Common.BRAND_USER, sid: Common.BRAND_SID, group: "DmQuanHuyen", action: "Index", cmd: "DmQuanHuyen.GetByMaTinhThanh", data: ModelRequestDistrictsByProvinceCodeCatalogDataClass(maTinhThanh: maTinhThanh), checksum: "")
        self.requestPOST(type: ModelOptionResponseDistrictsByProvinceCodeCatalog.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            if status == true {
                guard let repo = respo as? ModelOptionResponseDistrictsByProvinceCodeCatalog else {
                    return
                }
                if repo.code == 1 {
                    success(repo)
                    return
                } else {
                    failed(repo.code, repo.msg)
                }
            }
            failed(nil, nil)
        }
    }
    
    //    Danh sách nguồn đến
    func systemSourceToCatalog(maTinhThanh:String,callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = ModelRequestDistrictsByProvinceCodeCatalog(user: Common.BRAND_USER, sid: Common.BRAND_SID, group: "DmNguonDen", action: "Index", cmd: "DmNguonDen.GetAll", data: ModelRequestDistrictsByProvinceCodeCatalogDataClass(maTinhThanh: maTinhThanh), checksum: "")
        self.requestPOST(type: ModelOptionResponseSourceToCatalog.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            if status {
                if let data = (respo as? ModelOptionResponseSourceToCatalog)?.data {
                    SessionManager.shared.listNguonDen = data
                }
            }
            callBack(respo, status,code)
        }
    }
    //    Danh sách trạng thái (lịch hẹn)
    func systemStatusCatalog(request:ModelRequestSystemCatalog = ModelRequestSystemCatalog(user: Common.BRAND_USER, sid: Common.BRAND_SID, group: "DmTrangThai", action: "Index", cmd: "DmTrangThai.GetAll", data: DataClass(), checksum: ""),callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        self.requestPOST(type: ModelOptionResponseStatusCatalog.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    //    Danh sách phòng dịch vụ
    func systemAppointmentScheduleCatalog(request:ModelRequestSystemCatalog = ModelRequestSystemCatalog(user: Common.BRAND_USER, sid: Common.BRAND_SID, group: "DmPhongDichVu", action: "Index", cmd: "DmPhongDichVu.GetAll", data: DataClass(), checksum: ""),callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        self.requestPOST(type: ModelOptionResponseAppointmentScheduleCatalog.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    //    Danh sách nhân viên (có điều kiện tìm kiếm theo tên, theo nhóm nhân viên)
    func systemEmployeeAndSearchCatalog(tenNhanVien: String = "", idNhomNhanVien: Int = 0, pageNum: Int = 1, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request:ModelRequestEmployeeAndSearchCatalog = ModelRequestEmployeeAndSearchCatalog(user: Common.BRAND_USER, sid: Common.BRAND_SID, group: "DmNhanVien", action: "Index", cmd: "DmNhanVien.GetAll", data: ModelRequestEmployeeAndSearchCatalogDataClass(tenNhanVien: tenNhanVien, idNhomNhanVien: idNhomNhanVien, pageSize: Int(kDefaultPageSize), pageNum: pageNum), checksum: "")
        self.requestPOST(type: ModelOptionResponseEmployeeAndSearchCatalog.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    //    Danh sách nhóm nhân viên
    func systemEmployeeGroupCatalog(request:ModelRequestSystemCatalog = ModelRequestSystemCatalog(user: Common.BRAND_USER, sid: Common.BRAND_SID, group: "DmNhomNhanVien", action: "Index", cmd: "DmNhomNhanVien.GetAll", data: DataClass(), checksum: ""),callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        self.requestPOST(type: ModelOptionResponseEmployeeGroupCatalog.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    //    "Danh sách dịch vụ  - đơn giá dịch vụ "" :API danh mục dịch vụ : . Dữ liệu được phân quyền theo chi nhánh
    //    - Danh mục dịch vụ : ID, Tên, Ảnh, Đơn giá sale off, đơn giá bán, tóm tắt, nội dung"""
    //    """ API danh mục thẻ thanh toán :. Dữ liệu được phân quyền theo chi nhánh
    //    - Danh mục thẻ thanh toán : ID, Tên, Ảnh, Đơn giá"""
    func systemServiceCatalog(tenDichVu: String = "", pageNum: Int = 1, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request:ModelRequestServiceCatalog = ModelRequestServiceCatalog(user: Common.BRAND_USER, sid: Common.BRAND_SID, group: "DmDichVu", action: "Index", cmd: "DmDichVu.GetAll", data: ModelRequestServiceCatalogDataClass(tenDichVu: tenDichVu, idNhomDichVu: 0, pageSize: Int(kDefaultPageSize), pageNum: pageNum), checksum: "")
        self.requestPOST(type: ModelOptionResponseServiceCatalog.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    
    //    Danh mục thẻ thanh toán
    func systemCardServiceCatalog(tenTheDichVu: String = "", pageNum: Int = 1, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request:ModelRequestCardServiceCatalog = ModelRequestCardServiceCatalog(user: Common.BRAND_USER, sid: Common.BRAND_SID, group: "DmDichVu", action: "Index", cmd: "DmDichVu.GetAll", data: ModelRequestCardServiceCatalogDataClass(tenTheDichVu: tenTheDichVu, pageSize: Int(kDefaultPageSize), pageNum: pageNum), checksum: "")
        self.requestPOST(type: ModelOptionResponseCardServiceCatalog.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    
    //    Danh sách nguồn giới thiệu
    func systemReferralCatalog(request:ModelRequestSystemCatalog = ModelRequestSystemCatalog(user: Common.BRAND_USER, sid: Common.BRAND_SID, group: "DmNguonGioiThieu", action: "Index", cmd: "DmNguonGioiThieu.GetAll", data: DataClass(), checksum: ""),callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        self.requestPOST(type: ModelOptionResponseReferralCatalog.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            if status {
                if let data = (respo as? ModelOptionResponseReferralCatalog)?.data {
                    SessionManager.shared.listNguonGioiThieu = data
                }
            }
            callBack(respo, status,code)
        }
    }
    //    Danh mục loại khách hàng
    func systemCustomerTypeCatalog(request:ModelRequestSystemCatalog = ModelRequestSystemCatalog(user: Common.BRAND_USER, sid: Common.BRAND_SID, group: "DmLoaiKhachHang", action: "Index", cmd: "DmLoaiKhachHang.GetAll", data: DataClass(), checksum: ""),callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        self.requestPOST(type: ModelOptionResponseCustomerTypeCatalog.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    //    Danh sách nghề nghiệp
    func systemOccupationCatalog(request:ModelRequestSystemCatalog = ModelRequestSystemCatalog(user: Common.BRAND_USER, sid: Common.BRAND_SID, group: "DmNgheNghiep", action: "Index", cmd: "DmNgheNghiep.GetAll", data: DataClass(), checksum: ""),callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        self.requestPOST(type: ModelOptionResponseOccupationCatalog.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            if status == true {
                if let data = (respo as? ModelOptionResponseOccupationCatalog)?.data {
                    SessionManager.shared.listNgheNghiep = data
                }
            }
            callBack(respo, status,code)
        }
    }
    
    //    Danh mục xếp hạng thành viên
    func systemMemberRatingCatalog(request:ModelRequestSystemCatalog = ModelRequestSystemCatalog(user: Common.BRAND_USER, sid: Common.BRAND_SID, group: "DmXepHangThanhVien", action: "Index", cmd: "DmXepHangThanhVien.GetAll", data: DataClass(), checksum: ""),callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        self.requestPOST(type: ModelOptionResponseMemberRatingCatalog.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    //    Danh sách sản phẩm All + tìm kiếm. Muốn lấy all truyền vào tên sản phẩm = "" ("TenSanPham": "",
    //    - Danh muc Cộng Đồng Chủ Đề
    //    - Danh sách câu hỏi công đồng & câu trả lời
    //    - Xem chi tiết câu hỏi - Câu trả lời (Câu trả lời trả về 1 mảng gồm thông tin bác sỹ trả & nôi dung, ngày, v.v..v)
    func s(tenSanPham: String = "", pageNum: Int = 1,callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request:ModelRequestProductAndSearchCatalog = ModelRequestProductAndSearchCatalog(user: Common.BRAND_USER, sid: Common.BRAND_SID, group: "DmSanPham", action: "Index", cmd: "DmSanPham.GetAll", data: ModelRequestProductAndSearchCatalogDataClass(tenSanPham: tenSanPham, nhomSanPhamID: 0, loaiSanPhamID: 0, hangSanXuatID: 0, pageSize: Int(kDefaultPageSize), pageNum: pageNum), checksum: "")
        self.requestPOST(type: ModelOptionResponseProductAndSearchCatalog.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    //Danh muc Cộng Đồng Chủ Đề
    func systemSocialCatalog(request:ModelRequestSystemCatalog = ModelRequestSystemCatalog(user: Common.BRAND_USER, sid: Common.BRAND_SID, group: "CongDongDmNhomChuDe", action: "LIST", cmd: "CongDongDmNhomChuDe.GetAll", data: DataClass(), checksum: ""),callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        self.requestPOST(type: ModelOptionResponseSocialCatalog.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    
    func systemInvoiceCatalog(request:ModelRequestSystemCatalog = ModelRequestSystemCatalog(user: Common.BRAND_USER, sid: Common.BRAND_SID, group: "HoSoKhachHang", action: "LIST", cmd: "HoSoKhachHang.TrangThaiHoaDon", data: DataClass(), checksum: ""),callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        self.requestPOST(type: ModelOptionResponseInvoiceStatusCatalog.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    
    
}
