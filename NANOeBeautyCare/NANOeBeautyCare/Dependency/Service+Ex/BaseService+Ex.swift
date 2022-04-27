//
//  BaseService+Ex.swift
//  VitaPay
//
//  Created by Dom on 4/13/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import OneSignal


extension BaseService {
    func postSignInStaffService(request:SignInRequest,callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let domain = Common.HOST
        _ = self.initWith(baseURL: domain)
        self.requestPOST(type: SignInOptionalResponse.self, params: request.dictionary ?? [:], pathURL: .Login) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    
    func postSignInCustomerService(request:SignInRequest,callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let domain = Common.HOST
        _ = self.initWith(baseURL: domain)
        self.requestPOST(type: ModelBaseService<CustomerProfileOptionalResponse>.self, params: request.dictionary ?? [:], pathURL: .Login) { (respo, status, code) in
//            callBack(respo, status,code)
            if let repo = respo as? ModelBaseService<CustomerProfileOptionalResponse> {
                if repo.code == 1 {
                    SessionManager.shared.userInfo = repo.data
                    UserDefaults.standard.df.store(repo.data, forKey: String(describing: CustomerProfileOptionalResponse.self))
//                    var appSupportURL: String = (Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String) ?? ""
//                    if let bundleIdentifier = Bundle.main.bundleIdentifier {
//                        appSupportURL.appendingPathComponent("\(bundleIdentifier)").appendingPathComponent("Documents")
//                    }
                    let userid = OneSignal.getDeviceState().userId
                    print("UserID: \(userid)")
                    HospitalService().hospitalLoginNotify(requestData: HospitalService.HosLoginNotifyRequest(appid: userid ?? "", username: repo.data?.dienThoai ?? "", type: "KHACH_HANG")) { response, statusMess, statusCode in
                        callBack(respo, status, code)
                    }
                    return
                }
            }
            callBack(respo, status,code)
        }
    }
    
    func postUploadImage(request:UploadFile,callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void, progressUpload: @escaping (_ preogress: String) -> Void) {
        self.headers.update(name: "sid", value: CommonData.BRAND_SID)
        self.headers.update(name: "user", value: CommonData.BRAND_USER)
        print(headers)
        self.request(type: ModelBaseService<[UploadResponseDatum]>.self, method: .post, params: [:], pathURL: UrlString.AppServiceUpload.rawValue, attachData: [request], uploadProgress: { (progress) in
            progressUpload((String)(progress.fractionCompleted))
        }, complete: { (respo, status, code) in
            callBack(respo, status,code)
        })
    }
    
    
    func searchCustomerService(requestData: CustomerSearchRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<CustomerSearchRequest>(group: "DatLichHen", action: "EDIT", cmd: "DatLichHen.EDIT", data: requestData)
        
        self.requestPOST(type: ModelBaseService<CustomerSearchOptionalResponse>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    
    func provinceCodeCatalog(maTinhThanh: String, callBack: @escaping (_ status: Bool) -> Void) {
        Loading.startAnimation()
        self.systemDistrictsByProvinceCodeCatalog(maTinhThanh: maTinhThanh) { (response, status, code) in
            if status == true {
                guard let repo = response as? ModelOptionResponseDistrictsByProvinceCodeCatalog else {
                    return
                }
                if repo.code == 1 {
                    UserDefaults.standard.df.store(repo, forKey: String(describing: ModelOptionResponseDistrictsByProvinceCodeCatalog.self))
                    callBack(true)
                } else {
                }
            } else {
            }
            Loading.stopAnimation()
        }
    }
    func searchCustomerService(requestData: SearchCustomerAppointmentRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<SearchCustomerAppointmentRequest>(group: "DmKhachHang", action: "Search", cmd: "DmKhachHang.Search", data: requestData)
        
        self.requestPOST(type: ModelBaseService<[SearchCustomerAppointmentOptionalResponse]>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    
    func listPromotionService(requestData: CheckProductExited, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<CheckProductExited>(group: "HoSoKhachHang", action: "VIEW", cmd: "HoSoKhachHang.DanhSachChuongTrinhKhuyenMai", data: requestData)
        self.requestPOST(type: ModelBaseService<[PromotionProductOptionalResponse]>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    
    func seriaDiscountService(requestData: SeriaDiscountRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<SeriaDiscountRequest>(group: "HoSoKhachHang", action: "ADD", cmd: "HoSoKhachHang.GiamGia.MaGiamGia", data: requestData)
        self.requestPOST(type: ModelBaseService<SeriaDiscountOptionalResponse>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    
    func pointMemberSerivce(requestData: PointMemberRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<PointMemberRequest>(group: "HoSoKhachHang", action: "VIEW", cmd: "HoSoKhachHang.DiemTichLuy", data: requestData)
        self.requestPOST(type: ModelBaseService<PointMemberOptionalResponse>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    
    func transferPointMemberSerivce(requestData: TransferPointMemberRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<TransferPointMemberRequest>(group: "HoSoKhachHang", action: "VIEW", cmd: "HoSoKhachHang.QuyDoiDiemTichLuy", data: requestData)
        self.requestPOST(type: ModelBaseService<TransferPointMemberOptionalResponse>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    func customerDetailService(model: CustomerDetailRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        
        let request = CommonStructModel<CustomerDetailRequest>(group: "DmKhachHang", action: "VIEW", cmd: "DmKhachHang.XemChiTiet", data: model)
        
        self.requestPOST(type: ModelBaseService<CustomerDetailOptionalResponse>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    
    func suggestionCustomerService(requestData: SuggestionCustomerRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        
        let request = CommonStructModel<SuggestionCustomerRequest>(group: "DmDichVu", action: "Index", cmd: "DmDichVu.GetAll", data: requestData)
        
        self.requestPOST(type: ModelBaseService<[SuggestionCustomerHomeOptionalResponse]>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    
    func hosGetListMajor(requestData: SuggestionCustomerRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        
        let request = CommonStructModel<SuggestionCustomerRequest>(group: "DmKhoa", action: "LIST", cmd: "DmKhoa.GetAll", data: requestData)
        
        self.requestPOST(type: ModelBaseService<[ResponseMajorModel]>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    
//    {
//      "user": "",
//      "sid": "e8a4cf05-e188-4fd2-9a72-ae1f65d0ebe6",
//      "group": "DmNhanVien",
//      "action": "LIST",
//      "cmd": "DmNhanVien.BacSy",
//      "data": {
//        "TenNhanVien": "",
//        "MaNhom": "BAC_SY",
//        "IdKhoa": 0
//      },
//      "checksum": ""
//    }
    func hosGetListDoctorByMajor(requestData: EmployeeMajorRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        
        let request = CommonStructModel<EmployeeMajorRequest>(group: "DmNhanVien", action: "LIST", cmd: "DmNhanVien.BacSy", data: requestData)
        
        self.requestPOST(type: ModelBaseService<[ResponseDoctorByMajorModel]>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    
    //Lấy danh sách gói khám
    func hosGetListFunction(requestData: HosProductRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        
        let request = CommonStructModel<HosProductRequest>(group: "DmLoaiDichVu", action: "LIST", cmd: "DmLoaiDichVu.GetAll", data: requestData)
        
        self.requestPOST(type: ModelBaseService<[ResponseProductModel]>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    
    func hosGetListSubFunction(requestData: HosProductListSubFuntionRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        
        let request = CommonStructModel<HosProductListSubFuntionRequest>(group: "DmLoaiDichVu", action: "LIST", cmd: "DmLoaiDichVu.GetByMaLoaiDichVu", data: requestData)
        
        self.requestPOST(type: ModelBaseService<[ResponseProductListSubModel]>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    
    func hosGetFunctionDetail(requestData: HosProductDetailRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        
        let request = CommonStructModel<HosProductDetailRequest>(group: "DmLoaiDichVu", action: "LIST", cmd: "DmLoaiDichVu.ChiTiet", data: requestData)
        
        self.requestPOST(type: ModelBaseService<[ResponseProductListSubModel]>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    
    func hosGetFunctionSuperDetail(requestData: HosProductSuperDetailRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        
        let request = CommonStructModel<HosProductSuperDetailRequest>(group: "DmLoaiDichVu", action: "LIST", cmd: "DmDichVu.chiTietDichVu", data: requestData)
        
        self.requestPOST(type: ModelBaseService<ResponseProductDetailModel>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    
    func hosGetListService(requestData: HosServiceRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        
        let request = CommonStructModel<HosServiceRequest>(group: "DmComboGoiDichVuSanPham", action: "LIST", cmd: "DmComboGoi.GetAll", data: requestData)
        
        self.requestPOST(type: ModelBaseService<[ResponseComboServiceModel]>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    
    func hosGetServiceDetail(requestData: HosServiceDetailRequest, callBack: @escaping ([ResponseComboDetailModel]) -> Void) {
        
        let request = CommonStructModel<HosServiceDetailRequest>(group: "DmComboGoiDichVuSanPham", action: "LIST", cmd: "DmComboGoi.ChiTiet", data: requestData)
        
        self.requestPOST(type: ModelBaseService<[ResponseComboDetailModel]>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            self.handleArrayStatus(modelOptionalResponse: [ResponseComboDetailModel].self, response: respo, status, code, successBlock: { (repo) in
                callBack(repo.data ?? [])
            }) { (repo) in
            }
        }
    }
    
    func newCustomerService(requestData: NewCustomerRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {

        let request = CommonStructModel<NewCustomerRequest>(group: "NewsNoiDung", action: "List", cmd: "NewsNoiDung.GetAll", data: requestData)

        self.requestPOST(type: ModelBaseService<[NewCustomerHomeOptionalResponse]>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    
    func loginMoreService(requestData: MoreWebViewRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        
        let request = CommonStructModel<MoreWebViewRequest>(group: "Notification", action: "Login", cmd: "Notification.Login", data: requestData)

        self.requestPOST(type: ModelBaseService<MoreWebViewOptionalResponse>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    
    func logoutMoreService(requestData: MoreWebViewRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        
        let request = CommonStructModel<MoreWebViewRequest>(group: "Notification", action: "Login", cmd: "Notification.Logout", data: requestData)

        self.requestPOST(type: ModelBaseService<MoreWebViewOptionalResponse>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }

}
