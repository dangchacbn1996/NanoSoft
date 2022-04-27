//
//  CustomerAppointmentViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/22/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CustomerAppointmentViewController: BaseViewController<CustomerAppointmentPresenter> {
    // MARK: - IBOutlet
    
    
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = CustomerAppointmentPresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.presenter?.initDataPresent()
        self.defaultNavigation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    func defaultNavigation() {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = .boldSystemFont(ofSize: 17.0)
        label.text = "Navigation.Home".localized
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        self.navigationItem.titleView = nil
        self.rightButtonNavigation(isFiltterItem: true, actionFiltter: #selector(self.addFilter), actionSearch: #selector(self.addSearch))
    }

    @objc func addFilter() {
//        self.presenter?.openFilter()
    }

    @objc func addSearch() {
//        self.makeSearchBar(delegate: self)
    }

    override func updatePanData(context: RouteContext) {
        super.updatePanData(context: context)
        //        print(context[RVBackContext])
//        self.presenter?.updateBackContextData(context: context)
    }
    
     // MARK: - Update Data IBOutlet
    func updateData(data: ViewCustomerAppointment) {

    }

    // MARK: - Action Button
    
}

// MARK: - Protocol of Presenter
extension CustomerAppointmentViewController: CustomerAppointmentVC {
    func initData(data: ViewCustomerAppointment) {
    }
    
    func reloadData() {
    }
}


