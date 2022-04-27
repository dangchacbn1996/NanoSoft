//
//  SalesFilterPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/22/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol SalesFilterVC: BaseView {
    func initData(data:ViewSalesFilter)
    func reloadData()
}


class SalesFilterPresenter: BasePresenter<SalesFilterVC> {
    private let service = SalesFilterService()

    // MARK - Private Function
    var dataContext: SalesRequest?

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
