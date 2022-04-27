//
//  CreateSaleServiceService.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/30/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CreateSaleServiceService: BaseService {
    func createIDwithService(requestData: CardProductRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
          let request = CommonStructModel<CardProductRequest>(group: "DMTheDichVu", action: "Index", cmd: "DMTheDichVu.GetAll", data: requestData)
          self.requestPOST(type: ModelBaseService<[CardProductOptionalResponse]>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
              callBack(respo, status,code)
          }
      }

    func detailSaleService(requestData: CreateSaleServiceRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
          let request = CommonStructModel<CreateSaleServiceRequest>(group: "HoSoKhachHang", action: "VIEW", cmd: "HoSoKhachHang.ChiTiet", data: requestData)
          self.requestPOST(type: ModelBaseService<CreateSaleServiceOptionalResponse>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
              callBack(respo, status,code)
          }
      }

    func createIdxSaleService(requestData: TestRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<TestRequest>(group: "HoSoKhachHang", action: "ADD", cmd: "HoSoKhachHang.GetSoSTT_MaHoSo", data: requestData)
        self.requestPOST(type: ModelBaseService<SaleIdxOptionalResponse>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }

    func createSaleService(requestData: SaleCsServiceRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<SaleCsServiceRequest>(group: "HoSoKhachHang", action: "ADD", cmd: "HoSoKhachHang.AddHoSoKhachHang", data: requestData)
        self.requestPOST(type: ModelBaseService<CreateSaleServiceDataClass>.self, params: request.dictionary ?? [:], pathURL: .AppServiceCreateCustommer) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }

    func cancelPayment(requestData: CancelPaymentRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<CancelPaymentRequest>(group: "HoSoKhachHang", action: "DELETE", cmd: "HoSoKhachHang.Xoa", data: requestData)
        self.requestPOST(type: ModelBaseService<TestRequest>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }

    func confirmPayment(requestData: ConfirmPaymentRequest, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<ConfirmPaymentRequest>(group: "HoSoKhachHang", action: "ADD", cmd: "HoSoKhachHang.UpdateTrangThaiHoSo", data: requestData)
        self.requestPOST(type: ModelBaseService<TestRequest>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
}

