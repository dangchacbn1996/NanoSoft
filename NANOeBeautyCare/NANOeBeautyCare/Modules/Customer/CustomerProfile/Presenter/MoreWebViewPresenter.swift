//
//  MoreWebViewPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 10/01/2021
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol MoreWebViewVC: BaseView {
    func initData(data:ViewMoreWebView)
    func reloadData()
}


class MoreWebViewPresenter: BasePresenter<MoreWebViewVC> {
    private let service = MoreWebViewService()
    
    // MARK - Private Function
    var request = MoreWebViewRequest()

    func initDataPresent() {
        
    }
    
    func logoutService() {
       
    }
}
