//
//  SalesViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/8/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class SalesViewController: BaseViewController<SalesPresenter> {
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerXIBForHeaderFooter(SalesTableViewHeaderFooterView.identfier)
        }
    }
    var searchText: String = ""
    var items: [ViewSales] = []
    private var dataSource: TableDataSource<ViewSales, CellViewSales, SalesOptionalResponse>?
    
    @IBOutlet weak var createSaleServiceButton: UIButton!
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = SalesPresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //        self.navigationItem.title = "Navigation.Sales".localized
        self.presenter?.initDataPresent()
        
        self.defaultNavigation()
        
        self.configureTableView()
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
        label.text = "Navigation.Sales".localized
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        self.navigationItem.titleView = nil
        self.rightButtonNavigation(isFiltterItem: true, actionFiltter: #selector(self.addFilter), actionSearch: #selector(self.addSearch))
    }


    @objc func addFilter() {
        self.presenter?.openFilter()
    }

    private func configureTableView() {
        dataSource = TableDataSource<ViewSales, CellViewSales, SalesOptionalResponse>.init(.MultipleSection(items: self.items), tableView)

        dataSource?.addPullToRefresh = { [weak self] in
            self?.resetData()
            self?.presenter?.originalService()
        }

        dataSource?.addInfiniteScrolling = { [weak self] (page) in
            self?.presenter?.requestData.hoTen = self?.searchText ?? ""
            self?.presenter?.requestData.pageNum = page
            self?.presenter?.services()
        }

        dataSource?.configureHeaderFooter = { (section, item, view) in
            (view as? SalesTableViewHeaderFooterView)?.item = item
        }

        dataSource?.configureCell = { (cell, item, indexPath) in
            (cell as? SalesTableViewCell)?.item = item
        }

        dataSource?.didSelectRow = { (indexPath, item) in
            if let model = item?.property?.model {
                self.presenter?.detail(item: model)
            }
        }
    }
    
    @objc func addSearch() {
        self.makeSearchBar(delegate: self)
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewSales) {
        
    }
    
    // MARK: - Action Button
    @IBAction func createSaleServiceButtonAction(_ sender: Any) {
        self.presenter?.createSales()
    }

}

// MARK: - Protocol of Presenter
extension SalesViewController: SalesVC {
    func initData(data: [ViewSales]) {
        if data.count == 0 {
            if self.items.count > 0 {
                self.dataSource?.updateAndReload(for: .MultipleSection(items: self.items), .Complete)
            } else {
                //Show tableview empty
                self.dataSource?.updateAndReload(for: .MultipleSection(items: self.items), .FullReload)
            }
        } else {
            self.items.append(contentsOf:  data)
            self.dataSource?.updateAndReload(for: .MultipleSection(items: self.items), .FullReload)
        }
    }

    func reloadData() {
        self.dataSource?.stopInfiniteLoading(.FinishLoading)
    }

    func resetData() {
        self.items.removeAll()
    }
}
extension SalesViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //        searchActive = true;
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        //        searchActive = false;
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        self.resetData()
        self.defaultNavigation()
//        self.presenter?.originalService()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.defaultNavigation()
        self.resetData()
        self.searchText = searchBar.text ?? ""
        self.presenter?.requestData.hoTen = self.searchText.lowercased()
        self.presenter?.services()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            self.searchText = ""
            // refresh data
            self.presenter?.originalService()
        } else {
            self.resetData()
            self.searchText = searchBar.text ?? ""
            self.presenter?.requestData.hoTen = self.searchText.lowercased()
            self.presenter?.services()
        }
    }
}

