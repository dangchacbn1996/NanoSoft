//
//  AppointmentViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/8/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class AppointmentViewController: BaseViewController<AppointmentPresenter> {

    @IBOutlet weak var signInButton: MyGradientButton!
    @IBOutlet weak var viewGuest: UIView!
    @IBOutlet weak var signupButton: UIButton!
    let alertCustomer = AlertTwoButtonViewController()
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerXIBForHeaderFooter(AppointmentTableViewHeaderFooterView.identfier)
        }
    }
    @IBOutlet weak var createButton: UIButton!
    var searchText: String = ""
    var items: [ViewAppointment] = []
    private var dataSource: TableDataSource<ViewAppointment, CellViewAppointment, AppointmentOptionalResponse>?

    //    TableDataSource<DefaultHeaderFooterModel<AppointmentOptionalResponseDatum>, DefaultCellModel<AppointmentOptionalResponseDatum>,<AppointmentOptionalResponseDatum>?
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = AppointmentPresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.defaultNavigation()
        self.configureTableView()
        self.presenter?.initDataPresent()
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

    func defaultNavigation() {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = .boldSystemFont(ofSize: 17.0)
        label.text = "Navigation.Appointment".localized
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

    private func configureTableView() {
        dataSource = TableDataSource<ViewAppointment, CellViewAppointment, AppointmentOptionalResponse>.init(.MultipleSection(items: self.items), tableView)

        dataSource?.addPullToRefresh = { [weak self] in
            self?.items.removeAll()
            self?.presenter?.originalAppointment()
        }

        dataSource?.addInfiniteScrolling = { [weak self] (page) in
            self?.presenter?.requestData.tenKhachHang = self?.searchText ?? ""
            self?.presenter?.requestData.pageNum = page
            self?.presenter?.appointmentScheduleService()
        }

        dataSource?.configureHeaderFooter = { (section, item, view) in
            (view as? AppointmentTableViewHeaderFooterView)?.item = item
        }

        dataSource?.configureCell = { (cell, item, indexPath) in
            (cell as? AppointmentTableViewCell)?.item = item
            (cell as? AppointmentTableViewCell)?.moreAction.addAction(for: .touchUpInside, closure: { (button) in
                self.alertCustomer.dataModel = item?.property?.model
                self.alertCustomer.show()
            })
        }

        dataSource?.didSelectRow = { (indexPath, item) in
            if let model = item?.property?.model {
                self.presenter?.detailAppointment(item: model)
            }
        }
    }

    // MARK: - Update Data IBOutlet
    
    // MARK: - Action Button
    @IBAction func createButtonAction(_ sender: Any) {
        self.presenter?.createButton()
    }

    @IBAction func signupButtonAction(_ sender: Any) {
        self.openChildScreen(.CustomerSignUpViewController, fromStoryboard: .CustomerHome)
    }
    
    @IBAction func signinButtonAction(_ sender: Any) {
        self.logoutAction()
    }
}

// MARK: - Protocol of Presenter
extension AppointmentViewController: AppointmentVC {
    func initData(data: [ViewAppointment]) {
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
        self.dataSource?.updateAndReload(for: .MultipleSection(items: self.items), .FullReload)
    }
}
extension AppointmentViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //        searchActive = true;
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        //        searchActive = false;
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        self.resetData()
        self.defaultNavigation()
//        self.presenter?.originalAppointment()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.defaultNavigation()
        self.resetData()
        self.searchText = searchBar.text ?? ""
        self.presenter?.requestData.tenKhachHang = self.searchText.lowercased()
        self.presenter?.appointmentScheduleService()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            self.searchText = ""
            // refresh data
            self.presenter?.originalAppointment()
        } else {
            self.resetData()
            self.searchText = searchBar.text ?? ""
            self.presenter?.requestData.tenKhachHang = self.searchText.lowercased()
            self.presenter?.appointmentScheduleService()
        }
    }
}
