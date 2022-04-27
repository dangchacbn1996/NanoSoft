//
//  AppointmentFilterPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/22/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol AppointmentFilterVC: BaseView {
    func initData(data:ViewAppointmentFilter)
    func reloadData()
}


class AppointmentFilterPresenter: BasePresenter<AppointmentFilterVC> {
    private let service = AppointmentFilterService()
    
    // MARK - Private Function
    var dataContext: AppointmentRequest?

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
