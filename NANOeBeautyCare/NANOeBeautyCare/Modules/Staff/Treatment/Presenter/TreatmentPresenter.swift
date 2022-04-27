//
//  TreatmentPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/8/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol TreatmentVC: BaseView {
    func initData(data:[TreatmentOptionalResponse])
    func reloadData()
    func resetData()
}


class TreatmentPresenter: BasePresenter<TreatmentVC> {
    private let service = TreatmentService()
    
    // MARK - Private Function
    var requestData = TreatmentRequest()
    var backContext: TreatmentRequest?

    func initDataPresent() {
        self.originalService()
    }

    func originalService() {
        self.requestData = TreatmentRequest()
        self.remakeService()
    }

    func remakeService() {
        self.service.listTreatmentService(requestData: self.requestData) { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [TreatmentOptionalResponse].self, response: response, status, code, successBlock: { (repo) in
                if let data = repo.data {
                    self.viewController?.initData(data: data)
                }
                self.viewController?.reloadData()
            }) { (repo) in
                
            }
        }
    }
    
    func goToDetail(model: TreatmentOptionalResponse) {
        self.viewController?.openChildScreen(.DetailTreatmentViewController, fromStoryboard: .Treatment, withContext: RouteContext([RVContext: model]))
    }

    func updateBackContextData(context: RouteContext) {
        self.backContext = context[RVBackContext]
        if let backModel = self.backContext {
            self.requestData = backModel
            self.viewController?.resetData()
            self.remakeService()
        }
    }

    func openFilter() {
        self.viewController?.openChildScreen(.TreatmentFilterViewController, fromStoryboard: .Treatment, withContext: RouteContext([RVContext:self.requestData]))
    }
}
