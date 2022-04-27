//
//  HospitalServicePresenter.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 18/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

protocol HospitalServiceVC: BaseView {
//    func initData(data:[ViewHospitalMain])
    func reloadData()
    func reloadCombo()
}

class HospitalServicePresenter: BasePresenter<HospitalServiceVC> {
    static let keyProduct = "RVContextDetail"
    static let keyService = "RVContextService"
    
//    var productDetail: ResponseProductDetailModel? = nil
    var productDetail: ResponseProductListSubModel? = nil
    
    var serviceCode: ResponseComboServiceModel? = nil
    var serviceList: [ResponseComboDetailModel] = []
    let service = HospitalService()
    
    func initDataPresenter() {
//        if let detail = context?.getData(key: "") as? ResponseProductDetailModel {
//            self.serviceDetail = detail
//
//        }
        self.productDetail = context?[HospitalServicePresenter.keyProduct]
        self.serviceCode = context?[HospitalServicePresenter.keyService]
        self.viewController?.reloadCombo()
        getServiceList()
    }
    
    func getServiceList(key: String = "") {
        if let id = serviceCode?.IDComboGoiDVSP {
            self.service.hosGetServiceDetail(requestData: HosServiceDetailRequest(Id: id, TenDichVu: key)) { list in
                self.serviceList = list
                self.viewController?.reloadData()
            }
        }
    }
}
