//
//  CustomerDetailHistoryViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/20/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CustomerDetailHistoryViewController: BaseViewController<CustomerDetailHistoryPresenter> {
    // MARK: - IBOutlet

    // Khai báo và đăng ký Header, Cell, Dữ liệu
    @IBOutlet weak var tableView: UITableView!
    private var pageNo: UInt = 1
    var items: [CustomerDetailHistoryResponseElement] = []
    private var dataSource: TableDataSource<
    DefaultHeaderFooterModel<CustomerDetailHistoryResponseElement>,
    DefaultCellModel<CustomerDetailHistoryResponseElement>,
    CustomerDetailHistoryResponseElement>?

    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = CustomerDetailHistoryPresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Navigation.CustomerDetailHistory".localized
        self.presenter?.initDataPresent()
        self.backButtonNavigation()
        self.configureTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewCustomerDetailHistory) {

    }

    // Cấu hình Tableview
    // MARK: - TableView Setup
    private func configureTableView() {
        dataSource = TableDataSource<DefaultHeaderFooterModel<CustomerDetailHistoryResponseElement>, DefaultCellModel<CustomerDetailHistoryResponseElement>, CustomerDetailHistoryResponseElement>.init(.SingleListing(items: items, identifier: CustomerDetailHistoryTableViewCell.identfier, height: UITableView.automaticDimension, leadingSwipe: nil, trailingSwipe: nil), tableView)
        //            dataSource?.refreshProgrammatically()

        dataSource?.configureCell = { (cell, item, indexPath) in
            (cell as? CustomerDetailHistoryTableViewCell)?.item = item
        }

        dataSource?.addPullToRefresh = { [weak self] in
            //            self?.pageNo = 1
            self?.items.removeAll()
            self?.presenter?.updateService()
        }
    }
    
    // MARK: - Action Button
    
}

// MARK: - Protocol of Presenter
extension CustomerDetailHistoryViewController: CustomerDetailHistoryVC {
    func initData(data: [CustomerDetailHistoryResponseElement]) {
        self.items = data
        self.dataSource?.updateAndReload(for: .SingleListing(items: self.items), .FullReload)
    }

    func reloadData() {
        self.dataSource?.stopInfiniteLoading(.FinishLoading)
    }
}


