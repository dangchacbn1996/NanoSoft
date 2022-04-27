//
//  ProductSalesServiceService.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class ProductSalesServiceService: BaseService {
    func serviceProduct(requestData: ServiceProductRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
          let request = CommonStructModel<ServiceProductRequest>(group: "DmDichVu", action: "Index", cmd: "DmDichVu.GetAll", data: requestData)
          self.requestPOST(type: ModelBaseService<[ServiceProductOptionalResponse]>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
              callBack(respo, status,code)
          }
      }

    func catalogProduct(requestData: CatalogProductRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<CatalogProductRequest>(group: "DmSanPham", action: "Index", cmd: "DmSanPham.GetAll", data: requestData)
        self.requestPOST(type: ModelBaseService<[CatalogProductOptionalResponse]>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }

    func checkProduct(requestData: CheckProductRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<CheckProductRequest>(group: "HoSoKhachHang", action: "ADD", cmd: "HoSoKhachHang.KiemTraTonKho", data: requestData)
        self.requestPOST(type: ModelBaseService<CheckProductOptionalResponse>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }

    func cardProduct(requestData: CardProductRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<CardProductRequest>(group: "DMTheDichVu", action: "Index", cmd: "DMTheDichVu.GetAll", data: requestData)
        self.requestPOST(type: ModelBaseService<[CardProductOptionalResponse]>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }


}

