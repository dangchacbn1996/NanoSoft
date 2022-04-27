//
//  CustomerVIPListServiceViewController.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 09/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

class HospitalVIPListServiceViewController: UIViewController {
    private let tfSearch = UITextField(placeholder: "Tìm kiếm...", font: UIFont.customOpenSans(12), color: AppColors.textBlack)
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.view.addSubview(tfSearch)
        tfSearch.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().offset(-40)
            $0.height.equalTo(32)
        })
        tfSearch.layer.cornerRadius = 4
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints({
            $0.top.equalTo(tfSearch.snp.bottom).offset(20)
            $0.bottom.centerX.width.equalToSuperview()
        })
    }
}

//fileprivate class CustomerVIPListService
