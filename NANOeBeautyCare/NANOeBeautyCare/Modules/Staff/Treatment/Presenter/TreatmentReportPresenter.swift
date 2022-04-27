//
//  TreatmentReportPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 11/9/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol TreatmentReportVC: BaseView {
    func initData(data:DetailTreatmentOptionalResponse)
    func initUrlString(url:String, isCustomer: Bool)
    func reloadData()
}


class TreatmentReportPresenter: BasePresenter<TreatmentReportVC> {
    private let service = TreatmentReportService()
    
    // MARK - Private Function
    var URLContext: String?
    var isCustomer: Bool?
    var dataContext: DetailTreatmentOptionalResponse?

    func initDataPresent() {
        self.dataContext = context?[RVContext]
        if let model = self.dataContext {
            self.viewController?.initData(data: model)
        }

        self.URLContext = context?["URLContext"]
        self.isCustomer = context?["IsCustomer"]
        if let urlString = self.URLContext {
            if let isCus = self.isCustomer {
                self.viewController?.initUrlString(url: urlString, isCustomer: isCus)
            } else {
                self.viewController?.initUrlString(url: urlString, isCustomer: false)
            }
        }
        
    }
}
