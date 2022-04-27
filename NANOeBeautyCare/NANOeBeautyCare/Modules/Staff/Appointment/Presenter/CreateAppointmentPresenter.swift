//
//  CreateAppointmentPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/22/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol CreateAppointmentVC: BaseView {
    func initData(data:DetailAppointmentOptionalResponse)
    func updateDataCustomer(data:SuggestionCustomerHomeOptionalResponse)
    func updateDataService(data:[ResponseProductListSubModel])
    func updateDataComboService(data:ResponseComboServiceModel)
    func updateDataDoctor(data:ResponseDoctorByMajorModel)
    func reloadLayout(code: String)
    func reloadData()
    func updateListSearchBar(items: [CustomFormModelElement])
    func alertMessage(text: String)
    func updateInfomationFromHome(model: AppointmentOptionalResponse)
    func createAppointment(productName: String)
}


class CreateAppointmentPresenter: BasePresenter<CreateAppointmentVC> {
    
    static let RV_LIST_SERVICE = "RVContextListService"
    static let RV_COMBO_SERVICE = "RVContextLComboService"
    static let RV_PRODUCT_NAME = "RVContextProductName"
    static let RV_PRODUCT_CODE = "RVContextProductCode"
    
    private let service = CreateAppointmentService()
    
    // MARK - Private Function
    var createRequestModel = CreateAppointmentRequest(idLichHen: 0, tieuDe: "", maKhachHang: "", tenKhachHangDatHen: "", ngaySinh: "", maGioiTinh: 0, maTinhThanh: "", maQuanHuyen: "", diaChi: "", soDienThoai: "", email: "", batDau: "", ghiChu: "", soLuongKhach: 1, listMaDichVuYeuCau: "", listMaNhanVienYeuCau: "", idPhongDichVu: 0, idNguonDen: 0, idNguonGioiThieu: 0, trangThai: 0, khachHangID: (Common.BRAND_TYPE == BrandTypeEnum.Customer.rawValue) ? Common.BRAND_USER_ID : 0, idComboGoiDVSP: 0)

    var productName: String = "" {
        didSet {
            viewController?.createAppointment(productName: productName)
        }
    }
    var productCode: String = ""
    
    var dataContext: AppointmentOptionalResponse?
    var dataCustomer: SuggestionCustomerHomeOptionalResponse?
    var dataService: [ResponseProductListSubModel]?
    var dataComboService: ResponseComboServiceModel?
    var dataDetailAppointment:DetailAppointmentOptionalResponse?
    var dataDoctor: ResponseDoctorByMajorModel?

    func initDataPresent() {
        self.dataCustomer = context?["RVContextCustomer"]
        self.dataService = context?[CreateAppointmentPresenter.RV_LIST_SERVICE]
        self.dataComboService = context?[CreateAppointmentPresenter.RV_COMBO_SERVICE]
        self.productName = context?[CreateAppointmentPresenter.RV_PRODUCT_NAME] ?? ""
        self.productCode = context?[CreateAppointmentPresenter.RV_PRODUCT_CODE] ?? ""
        createRequestModel.maLoaiDichVu = self.productCode
        self.dataDoctor = context?["RVContextDoctor"]
        if let model = self.dataCustomer {
            self.viewController?.updateDataCustomer(data: model)
        }
        if let model = self.dataService {
            self.viewController?.updateDataService(data: model)
        }
        if let model = self.dataComboService {
            self.viewController?.updateDataComboService(data: model)
        }
        if let model = self.dataDoctor {
            self.viewController?.updateDataDoctor(data: model)
        }
        self.dataContext = context?[RVContext]
        if let model = self.dataContext {
            self.viewController?.updateInfomationFromHome(model: model)
            if let idx = model.idLichHen {
                self.readService(idx: idx)
            }
        }
        self.viewController?.reloadLayout(code: productCode)
    }

    func readService(idx: Int) {
        self.service.readAppointmentService(requestData: DetailAppointmentRequest(idLichHen: idx)) { (response, status, code) in
            self.service.handleObjectStatus(modelOptionalResponse: DetailAppointmentOptionalResponse.self, response: response, status, code, successBlock: { (repo) in
                if let data = repo.data {
                    self.dataDetailAppointment = data
                    self.viewController?.initData(data: data)
                }
            }) { (repo) in

            }
        }
    }
    
    func services() {
        print("----")
        self.createRequestModel.batDau = self.createRequestModel.thoigian.joined(separator: " ")
        print(self.createRequestModel)
        if self.dataContext != nil {
            self.updateService()
        } else {
            self.saveService()
        }
    }

    func saveService() {
        self.service.createAppointmentService(requestData: createRequestModel) { (response, status, code) in
            self.service.handleObjectStatus(modelOptionalResponse: CreateAppointmentOptionalResponse.self, response: response, status, code, successBlock: { (repo) in
                self.viewController?.alertMessage(text: repo.msg ?? "")
            }) { (repo) in

            }
        }
    }

    func updateService() {
        self.service.updateAppointmentService(requestData: createRequestModel) { (response, status, code) in
            self.service.handleObjectStatus(modelOptionalResponse: CreateAppointmentOptionalResponse.self, response: response, status, code, successBlock: { (repo) in
                self.viewController?.alertMessage(text: repo.msg ?? "")
            }) { (repo) in

            }
        }
    }

    func searchService(search: String) {
        self.service.searchCustomerService(requestData: SearchCustomerAppointmentRequest(keyWord: search)) { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [SearchCustomerAppointmentOptionalResponse].self, response: response, status, code, successBlock: { (repo) in
                var items : [CustomFormModelElement] = []
                if let data = repo.data {
                    for item in data {
                        items.append(CustomFormModelElement(selected: item.hoTen, rawItem: item as AnyObject, isSelected: false))
                    }
                }
                self.viewController?.updateListSearchBar(items: items)
            }) { (repo) in

            }
        }
    }

    func district(idx: String, callBack: @escaping (_ status: Bool) -> Void) {
        self.service.provinceCodeCatalog(maTinhThanh: idx, callBack: callBack)
    }
}
