//
//  DiscountRateSaleServicePresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/30/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol DiscountRateSaleServiceVC: BaseView {
    func initData(data:ViewDiscountRateSaleService)
    func reloadData()
}


class DiscountRateSaleServicePresenter: BasePresenter<DiscountRateSaleServiceVC> {
    private let service = DiscountRateSaleServiceService()
    
    // MARK - Private Function
    

    func initDataPresent() {
        self.services()
    }
    
    func services() {
       
    }
}
