//
//  EditSpaServicePresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/15/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol EditSpaServiceVC: BaseView {
    func initData(data:ListService)
    func reloadData()
    func updateSeria(model: SeriaDiscountOptionalResponse)
}


class EditSpaServicePresenter: BasePresenter<EditSpaServiceVC> {
    private let service = EditSpaServiceService()
    
    // MARK - Private Function
    var dataContext: ListService?
    var modelRequest = SeriaDiscountRequest(id: -1, loai: "", maKhuyenMai: "")
    
    func initDataPresent() {
        self.dataContext = context?[RVContext]
        if let data = self.dataContext {
            self.viewController?.initData(data: data)
            self.listPromition(requestData: CheckProductExited(id: data.id, loai: data.loai ?? ""))
            self.modelRequest.id = data.id
            self.modelRequest.loai = data.loai
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
