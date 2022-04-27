//
//  HospitalListServicePresenter.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 19/05/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol HospitalListServiceVC: BaseView {
    func initData(data:[ViewHeadFootServiceProvider])
    func reloadData()
}

class HospitalListServicePresenter: BasePresenter<HospitalListServiceVC> {

    private let service = CustomerHomeService()
    private var productModel: ResponseProductModel? = nil
    var listData: [ResponseProductListSubModel] = []
    var data: [ViewHeadFootServiceProvider] = []
    var titleText: String = "Dịch vụ"
    
    func initDataPresenter() {
        self.titleText = context?["RVTitle"] ?? "Dịch vụ"
        self.listData = context?["RVContext"] ?? []
        self.productModel = context?["RVProduct"]
        
        var cellContact: [CellServiceProvider] = []
        self.listData.forEach({
            cellContact.append(CellServiceProvider((identifier: HospitalServiceItem.id, height: 136, model: CellServiceHospitalMain(serviceList: $0))))
        })
        if DataManager.shared.companyModel?.DienThoai?.isEmpty ?? true {
            self.data.append(ViewHeadFootServiceProvider(nil, nil, [CellServiceProvider((identifier: HospitalContactInfoTableViewCell.id, height: 0, model: nil))]))
        } else {
        self.data.append(ViewHeadFootServiceProvider(nil, nil, [CellServiceProvider((identifier: HospitalContactInfoTableViewCell.id, height: 94, model: nil))]))
        }
        self.data.append(ViewHeadFootServiceProvider(nil, nil, cellContact))
        self.viewController?.initData(data: self.data)
        self.viewController?.reloadData()
    }
    
//    {
//      "sid": "591dd951-5dff-4d7c-88ca-c2ae3f79f9ae",
//      "cmd": "DmDichVu.chiTietDichVu",
//      "data": {
//         "DichVuID": 101
//      },
//      "checksum": ""
//    }
    func showDetail(data: ResponseProductListSubModel, success: @escaping (ResponseProductDetailModel) -> Void) {
        self.service.hosGetFunctionSuperDetail(requestData: HosProductSuperDetailRequest(id: data.ID)) { (response, status, code) in
            self.service.handleObjectStatus(modelOptionalResponse: ResponseProductDetailModel.self, response: response, status, code) { repo in
                if let model = repo.data {
                    success(model)
                }
            } failureBlock: { repo in
                print(repo.data)
            }
        }
    }
    
    func getProductDetail(textSearch: String) {
        self.service.hosGetListSubFunction(requestData: HosProductListSubFuntionRequest(page_num: 1, page_size: 1000, TenDichVu: textSearch , MaLoaiDichVu: self.productModel?.MaLoaiDichVu ?? "")) { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [ResponseProductListSubModel].self, response: response, status, code, successBlock: { (repo) in
                self.listData = repo.data ?? []
                self.data = []
                var cellContact: [CellServiceProvider] = []
                self.listData.forEach({
                    cellContact.append(CellServiceProvider((identifier: HospitalServiceItem.id, height: 136, model: CellServiceHospitalMain(serviceList: $0))))
                })
                self.data.append(ViewHeadFootServiceProvider(nil, nil, cellContact))
                self.viewController?.initData(data: self.data)
                self.viewController?.reloadData()
            }) { (repo) in
            }
        }
    }
}

//ViewCustomerHome
class ViewHeadFootServiceProvider: HeaderFooterModelProvider {
    
    typealias CellModelType = CellServiceProvider
    typealias HeaderModelType = Any
    typealias FooterModelType = Any

    var headerProperty: (identifier: String?, height: CGFloat?, model: Any?)?
    var items: [CellServiceProvider]?
    var footerProperty: (identifier: String?, height: CGFloat?, model: Any?)?

    required init(_ _header: (identifier: String?, height: CGFloat?, model: Any?)?, _ _footer: (identifier: String?, height: CGFloat?, model: Any?)?, _ _items: [CellServiceProvider]?) {
        headerProperty = _header
        items = _items
        footerProperty = _footer
    }
}

//CellServiceProvider
struct CellServiceProvider: CellModelProvider {
    
    typealias CellModelType = CellServiceHospitalMain
    var property: (identifier: String, height: CGFloat?, model: CellServiceHospitalMain?)?

    init(_ _property: (identifier: String, height: CGFloat?, model: CellServiceHospitalMain?)?) {
        property = _property
    }
}

//EnumTypeCellDataCustomerHome
enum EnumTypeCellServiceHospitalMain: Int {
    case Introduce = 0
}

//CellDataCustomerHome
struct CellServiceHospitalMain {
    var serviceList: ResponseProductListSubModel
    var selected: Bool = false
//    var agencyCustomer: [AgencyCustomerHomeOptionalResponse]?
}

