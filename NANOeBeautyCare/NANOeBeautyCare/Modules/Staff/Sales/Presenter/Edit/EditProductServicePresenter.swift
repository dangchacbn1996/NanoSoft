//
//  EditProductServicePresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/7/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol EditProductServiceVC: BaseView {
    func initData(data:ListService)
    func reloadData()
    func updateFirstUnit(model: CheckProductOptionalResponse)
    func updateSeria(model: SeriaDiscountOptionalResponse)
}


class EditProductServicePresenter: BasePresenter<EditProductServiceVC> {
    private let service = EditProductServiceService()
    var modelRequest = SeriaDiscountRequest(id: -1, loai: "", maKhuyenMai: "")
    // MARK - Private Function
    var dataContext: ListService?
    
    func initDataPresent() {
        self.dataContext = context?[RVContext]
        if let data = self.dataContext {
            self.viewController?.initData(data: data)
            self.listPromition(requestData: CheckProductExited(id: data.id, loai: data.loai ?? ""))
            print("12312312______")
            print(data.loai ?? "")
            self.modelRequest.id = data.id
            self.modelRequest.loai = data.loai
            if data.loai == "SAN_PHAM" {
                self.checkedProduct(requestData: CheckProductRequest(sanPhamID: data.id))
            }
        }
    }

    func services(model: ListService) {
        self.viewController?.backToPrevScreen(with: RouteContext(["BackListServiceContext": model]))
    }
    
    func listPromition(requestData: CheckProductExited) {
        self.service.listPromotionService(requestData: requestData) { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [PromotionProductOptionalResponse].self, response: response, status, code, successBlock: { (repo) in
                print("----12313123")
                UserDefaults.standard.df.store(repo.data, forKey: String(describing: [PromotionProductOptionalResponse].self))
            }) { (model) in
                
            }
        }
    }
    
    func checkedProduct(requestData: CheckProductRequest) {
        self.service.checkExitedService(requestData: requestData) { (response, status, code) in
            self.service.handleObjectStatus(modelOptionalResponse: CheckProductOptionalResponse.self, response: response, status, code, successBlock: { (repo) in
                
                var dataItems: [CheckProductOptionalResponse] = []
                // Tạo mảng 3 phần tử để lấy thông tin Đơn Vị
                for index in 0...2 {
                    if index == 0 {
                        let dataCustom = repo.data
                        var custom = dataCustom
                        custom?.tenChoose = dataCustom?.tenDonViMin
                        custom?.maDonViChoose = dataCustom?.maDonViMin
                        custom?.soLuongChoose = dataCustom?.soLuongTonMin
                        if let data = custom {
                            dataItems.append(data)
                        }
                    } else if index == 1 {
                        let dataCustom = repo.data
                        var custom = dataCustom
                        custom?.tenChoose = dataCustom?.tenDonVi2
                        custom?.maDonViChoose = dataCustom?.maDonVi2
                        custom?.soLuongChoose = dataCustom?.soLuongTon2
                        if let data = custom {
                            dataItems.append(data)
                        }
                    } else if index == 2 {
                        let dataCustom = repo.data
                        var custom = dataCustom
                        custom?.tenChoose = dataCustom?.tenDonViMax
                        custom?.maDonViChoose = dataCustom?.maDonViMax
                        custom?.soLuongChoose = dataCustom?.soLuongTonMax
                        if let data = custom {
                            dataItems.append(data)
                        }
                    }
                }
                
                UserDefaults.standard.df.store(dataItems, forKey: String(describing: [CheckProductOptionalResponse].self))
                if let model = dataItems.first {
                    self.viewController?.updateFirstUnit(model: model)
                }
            }) { (model) in
                
            }
        }
    }

    func seriaDiscountChecked() {
        self.service.seriaDiscountService(requestData: self.modelRequest) { (response, status, code) in
            self.service.handleObjectStatus(modelOptionalResponse: SeriaDiscountOptionalResponse.self, response: response, status, code, successBlock: { (repo) in
                if let model = repo.data {
                    self.viewController?.updateSeria(model: model)
                }
            }) { (model) in

            }
        }
    }
}
