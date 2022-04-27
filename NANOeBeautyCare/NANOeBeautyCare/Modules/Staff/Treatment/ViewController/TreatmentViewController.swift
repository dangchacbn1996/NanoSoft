//
//  TreatmentViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/8/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class TreatmentViewController: BaseViewController<TreatmentPresenter> {
    // MARK: - IBOutlet
    @IBOutlet weak var signInButton: MyGradientButton!
    @IBOutlet weak var viewGuest: UIView!
    @IBOutlet weak var signupButton: UIButton!
    
    var searchText: String = ""
    let alertCustomer = AlertTwoButtonViewController()
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            //            tableView.registerXIB(TreatmentTableViewCell.identfier)
        }
    }
    var items: [TreatmentOptionalResponse] = []
    private var pageNo:UInt = 1
    private var dataSource: TableDataSource<DefaultHeaderFooterModel<TreatmentOptionalResponse>,
                                            DefaultCellModel<TreatmentOptionalResponse>,
                                            TreatmentOptionalResponse>?
    
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = TreatmentPresenter()
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.viewGuest.isHidden = !Common.IS_GUEST
    }

    override func updatePanData(context: RouteContext) {
        super.updatePanData(context: context)
        //        print(context[RVBackContext])
        self.presenter?.updateBackContextData(context: context)
    }

    
    // MARK: - TableView Setup
    private func configureTableView() {
        dataSource = TableDataSource<DefaultHeaderFooterModel<TreatmentOptionalResponse>, DefaultCellModel<TreatmentOptionalResponse>, TreatmentOptionalResponse>.init(.SingleListing(items: items, identifier: TreatmentTableViewCell.identfier, height: UITableView.automaticDimension, leadingSwipe: nil, trailingSwipe: nil), tableView)
        
        dataSource?.addPullToRefresh = { [weak self] in
            self?.resetData()
            self?.presenter?.originalService()
        }
        
        dataSource?.addInfiniteScrolling = { [weak self] (page) in
//            self?.presenter?.requestData.hoTen = self?.searchText ?? ""
            self?.presenter?.requestData.pageNum = page
            self?.presenter?.remakeService()
        }
        
        dataSource?.configureCell = { (cell, item, indexPath) in
            (cell as? TreatmentTableViewCell)?.item = item
            (cell as? TreatmentTableViewCell)?.moreButton.addAction(for: .touchUpInside, closure: { (button) in
                self.alertCustomer.dataModelTreatment = item?.property?.model
                self.alertCustomer.show()
            })
        }
        
        dataSource?.didSelectRow = { (indexPath, item) in
            if let model = item?.property?.model {
                self.presenter?.goToDetail(model: model)
            }
        }
        
    }
    
    func defaultNavigation() {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = .boldSystemFont(ofSize: 17.0)
        label.text = "Navigation.Treatment".localized
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        self.navigationItem.titleView = nil
        self.rightButtonNavigation(isFiltterItem: true, actionFiltter: #selector(self.addFilter), actionSearch: #selector(self.addSearch))
    }
    
    @objc func addFilter() {
        self.presenter?.openFilter()
    }
    
    @objc func addSearch() {
        self.makeSearchBar(delegate: self)
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewTreatment) {
        
    }
    
    // MARK: - Action Button
    @IBAction func signupButtonAction(_ sender: Any) {
        self.openChildScreen(.CustomerSignUpViewController, fromStoryboard: .CustomerHome)
    }
    
    @IBAction func signinButtonAction(_ sender: Any) {
        self.logoutAction()
    }
}

// MARK: - Protocol of Presenter
extension TreatmentViewController: TreatmentVC {
    func resetData() {
        self.items.removeAll()
    }
    
    func initData(data: [TreatmentOptionalResponse]) {
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
extension TreatmentViewController: UISearchBarDelegate {
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
        self.resetData()
        self.defaultNavigation()
        self.searchText = searchBar.text ?? ""
        self.presenter?.requestData.timKiem = self.searchText.lowercased()
        self.presenter?.remakeService()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            self.searchText = ""
            // refresh data
            self.presenter?.originalService()
        } else {
            self.resetData()
            self.searchText = searchBar.text ?? ""
            self.presenter?.requestData.timKiem = self.searchText.lowercased()
            self.presenter?.remakeService()
        }
    }
}
