//
//  DiscountRateSaleServiceViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/30/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class DiscountRateSaleServiceViewController: BaseViewController<DiscountRateSaleServicePresenter> {
    // MARK: - IBOutlet
    
    
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = DiscountRateSaleServicePresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Navigation.DiscountRateSaleService".localized
        self.presenter?.initDataPresent()
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewDiscountRateSaleService) {

    }
    
    // MARK: - Action Button
    
}

// MARK: - Protocol of Presenter
extension DiscountRateSaleServiceViewController: DiscountRateSaleServiceVC {
    func initData(data: ViewDiscountRateSaleService) {
    }
    
    func reloadData() {
    }
}


