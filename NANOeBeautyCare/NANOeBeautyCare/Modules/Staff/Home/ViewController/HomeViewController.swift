//
//  HomeViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/8/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController<HomePresenter> {
    // MARK: - IBOutlet
//    var searchActive:Bool = false
    var searchText: String = ""
    let alertCustomer = AlertCustomerViewController()

    @IBOutlet weak var createButton: UIButton!
    // declare a dataSource
    var items: [HomeOptionalResponse] = []
    private var dataSource: TableDataSource<DefaultHeaderFooterModel<HomeOptionalResponse>,
    DefaultCellModel<HomeOptionalResponse>,
    HomeOptionalResponse>?

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = HomePresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

        self.presenter?.initDataPresent()
        self.defaultNavigation()
        self.configureTableView()

        self.presenter?.customerPortfolioService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    override func updatePanData(context: RouteContext) {
        super.updatePanData(context: context)
        //        print(context[RVBackContext])
        self.presenter?.updateBackContextData(context: context)
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

    // MARK: - TableView Setup
    private func configureTableView() {
        dataSource = TableDataSource<DefaultHeaderFooterModel<HomeOptionalResponse>, DefaultCellModel<HomeOptionalResponse>, HomeOptionalResponse>.init(.SingleListing(items: items, identifier: HomeTableViewCell.identfier, height: 120.0, leadingSwipe: nil, trailingSwipe: nil), tableView)
        //            dataSource?.refreshProgrammatically()

        dataSource?.configureCell = { (cell, item, indexPath) in
            (cell as? HomeTableViewCell)?.item = item
            (cell as? HomeTableViewCell)?.actionButton.addAction(for: .touchUpInside, closure: { (button) in
                self.alertCustomer.dataModel = item?.property?.model
                self.alertCustomer.show()
            })
        }

        dataSource?.addPullToRefresh = { [weak self] in
            self?.resetData()
            self?.presenter?.originCustomerService()
        }

        dataSource?.addInfiniteScrolling = { [weak self] (page) in
            self?.presenter?.requestData.keyWord = self?.searchText ?? ""
            self?.presenter?.requestData.pageNum = page
            self?.presenter?.customerPortfolioService()
        }
        dataSource?.didSelectRow = { (indexPath, item) in
            if let model = item?.property?.model {
                self.openChildScreen(.CustomerDetailViewController, fromStoryboard: .Home, withContext: RouteContext([RVContext: model]))
            }
        }
    }
    
    @objc func addFilter() {
        self.presenter?.openFilter()
    }
    
    @objc func addSearch() {
        self.makeSearchBar(delegate: self)
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewHome) {
        
    }
    
    // MARK: - Action Button
    @IBAction func createButton(_ sender: Any) {
        self.presenter?.createCustomer()
        //        CustomFormViewController().show()
        //        CommonView.alertCity { (dataa) in
        //
        //        }
        
    }
    
}

// MARK: - Protocol of Presenter
extension HomeViewController: HomeVC {
    func resetData() {
        self.items.removeAll()
    }

    func initData(data: [HomeOptionalResponse]) {
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
extension HomeViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        self.resetData()
        self.defaultNavigation()
//        self.presenter?.originCustomerService()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.resetData()
        self.defaultNavigation()
        self.searchText = searchBar.text ?? ""
        self.presenter?.requestData.keyWord = self.searchText.lowercased()
        self.presenter?.customerPortfolioService()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            self.searchText = ""
            // refresh data
            self.presenter?.originCustomerService()
        } else {
            self.resetData()
            self.searchText = searchBar.text ?? ""
            self.presenter?.requestData.keyWord = self.searchText.lowercased()
            self.presenter?.customerPortfolioService()
        }
    }
}
