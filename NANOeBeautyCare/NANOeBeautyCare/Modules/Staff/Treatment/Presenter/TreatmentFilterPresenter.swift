//
//  TreatmentFilterPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/22/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol TreatmentFilterVC: BaseView {
    func initData(data:ViewTreatmentFilter)
    func reloadData()
}


class TreatmentFilterPresenter: BasePresenter<TreatmentFilterVC> {
    private let service = TreatmentFilterService()
    
    // MARK - Private Function
    var dataContext: TreatmentRequest?

    func initDataPresent() {
        self.dataContext = context?[RVContext]
    }

    func cancel() {
        self.viewController?.backToPrevScreen(with: RouteContext([:]))
    }

    func save() {
        self.viewController?.backToPrevScreen(with: RouteContext([RVBackContext: self.dataContext]))
    }
}
