//
//  TreatmentEditDetailPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 11/9/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol TreatmentEditDetailVC: BaseView {
    func initData(data:DetailTreatmentOptionalResponse)
    func reloadData()
    func updateStatus(isSuccess: Bool)
}


class TreatmentEditDetailPresenter: BasePresenter<TreatmentEditDetailVC> {
    private let service = TreatmentEditDetailService()

    // MARK - Private Function
    var dataContext: DetailTreatmentOptionalResponse?
    var requestModel: TreatmentEditDetailRequest = TreatmentEditDetailRequest()

    func initDataPresent() {
        self.dataContext = context?[RVContext]
        if let model = self.dataContext {
            self.viewController?.initData(data: model)
        }
    }

    func services() {
        self.service.postUpdateTreatmentService(requestData: self.requestModel) { (response, status, code) in
            self.service.handleObjectStatus(modelOptionalResponse: TreatmentReportOptionalResponse.self, response: response, status, code, successBlock: { (repo) in
                self.viewController?.updateStatus(isSuccess: true)
            }) { (repo) in
                self.viewController?.updateStatus(isSuccess: false)
            }
        }
    }
}
