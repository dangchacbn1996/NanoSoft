//
//  CustomerHomeFilterViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 24/11/2020
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CustomerHomeFilterViewController: BaseViewController<CustomerHomeFilterPresenter> {
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    var items: [SuggestionCustomerHomeOptionalResponse] = []
    var searchText: String = ""
    private var dataSource: TableDataSource<DefaultHeaderFooterModel<SuggestionCustomerHomeOptionalResponse>,
    DefaultCellModel<SuggestionCustomerHomeOptionalResponse>,
    SuggestionCustomerHomeOptionalResponse>?

    
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = CustomerHomeFilterPresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Dịch vụ"
        self.navigationController?.navigationBar.isHidden = false
        self.presenter?.initDataPresent()
        self.backButtonNavigation()
        self.configureTableView()
    }

    // MARK: - TableView Setup
    private func configureTableView() {
        dataSource = TableDataSource<DefaultHeaderFooterModel<SuggestionCustomerHomeOptionalResponse>, DefaultCellModel<SuggestionCustomerHomeOptionalResponse>, SuggestionCustomerHomeOptionalResponse>.init(.SingleListing(items: items, identifier: CustomerHomeFilterTableViewCell.identfier, height: 265.0.auto(), leadingSwipe: nil, trailingSwipe: nil), tableView)
        //            dataSource?.refreshProgrammatically()

        dataSource?.configureCell = { (cell, item, indexPath) in
            (cell as? CustomerHomeFilterTableViewCell)?.item = item
            (cell as? CustomerHomeFilterTableViewCell)?.appointmentButton.addAction(for: .touchUpInside, closure: { (button) in
                if Common.IS_GUEST {
                    self.alertGuest()
                } else {
                    self.openChildScreen(.CreateAppointmentViewController, fromStoryboard: .Appointment, withContext: RouteContext(["RVContextCustomer":item?.property?.model]))
                }
            })
        }

        dataSource?.addPullToRefresh = { [weak self] in
            self?.resetData()
            self?.presenter?.orginSerivce()
        }

        dataSource?.addInfiniteScrolling = { [weak self] (page) in
            self?.presenter?.requestSuggestionCustomer.tenDichVu = self?.searchText ?? ""
            self?.presenter?.requestSuggestionCustomer.pageNum = page
            self?.presenter?.services()
        }
        dataSource?.didSelectRow = { (indexPath, item) in
            if let model = item?.property?.model {
//                self.openChildScreen(.CustomerDetailViewController, fromStoryboard: .Home, withContext: RouteContext([RVContext: model]))
                self.openChildScreen(.CustomerHomeAppointmentViewController, fromStoryboard: .CustomerHome, withContext: RouteContext([RVContext:model]))
            }
        }
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewCustomerHomeFilter) {

    }
    
    // MARK: - Action Button
    
}

// MARK: - Protocol of Presenter
extension CustomerHomeFilterViewController: CustomerHomeFilterVC {
    func resetData() {
        self.items.removeAll()
    }

    func initData(data: [SuggestionCustomerHomeOptionalResponse]) {
        if data.count == 0 {
            if self.items.count > 0 {
                self.dataSource?.updateAndReload(for: .SingleListing(items: self.items), .Complete)
            } else {
                //Show tableview empty
                self.dataSource?.updateAndReload(for: .SingleListing(items: self.items), .FullReload)
            }
        } else {
            self.items.append(contentsOf:  data)
            self.dataSource?.updateAndReload(for: .SingleListing(items: self.items), .FullReload)
        }
    }

    func reloadData() {
        self.dataSource?.stopInfiniteLoading(.FinishLoading)
    }
}
extension CustomerHomeFilterViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        searchActive = true;
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        searchActive = false;
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        self.resetData()
//        self.presenter?.originCustomerService()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.resetData()
        self.searchText = searchBar.text ?? ""
        self.presenter?.requestSuggestionCustomer.tenDichVu = self.searchText.lowercased()
        self.presenter?.services()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            self.searchText = ""
            // refresh data
            self.presenter?.orginSerivce()
        } else {
            self.resetData()
            self.searchText = searchBar.text ?? ""
            self.presenter?.requestSuggestionCustomer.tenDichVu = self.searchText.lowercased()
            self.presenter?.services()
        }
    }
}
