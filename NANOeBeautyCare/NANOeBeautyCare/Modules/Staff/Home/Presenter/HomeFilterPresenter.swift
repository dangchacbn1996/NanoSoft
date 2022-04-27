//
//  HomeFilterPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/15/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol HomeFilterVC: BaseView {
    func initData(data:ViewHomeFilter)
    func reloadData()
}


class HomeFilterPresenter: BasePresenter<HomeFilterVC> {
    private let service = HomeFilterService()
    
    // MARK - Private Function
    var dataContext: HomeRequest?

    func initDataPresent() {
        self.dataContext = context?[RVContext]
    }
    
    func services() {
       
    }

    func cancel() {
        self.viewController?.backToPrevScreen(with: RouteContext([:]))
    }

    func save() {
        self.viewController?.backToPrevScreen(with: RouteContext([RVBackContext: self.dataContext]))
    }
}
