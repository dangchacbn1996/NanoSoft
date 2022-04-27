//
//  FilterCustomerSocialPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 23/11/2020
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol FilterCustomerSocialVC: BaseView {
    func initData(data:ViewFilterCustomerSocial)
    func reloadData()
}


class FilterCustomerSocialPresenter: BasePresenter<FilterCustomerSocialVC> {
    private let service = FilterCustomerSocialService()
    
    // MARK - Private Function
    

    func initDataPresent() {
        self.services()
    }
    
    func services() {
       
    }
}
