//
//  CustomerHomeNewsViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 10/10/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CustomerHomeNewsViewController: BaseViewController<CustomerHomeNewsPresenter> {
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    var items: [ViewCustomerHomeNews] = []
    private var dataSource: TableDataSource<ViewCustomerHomeNews,
                                            CellViewCustomerHomeNews,
                                            CellDataCustomerHomeNews>?

    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = CustomerHomeNewsPresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        self.title = "Navigation.CustomerHomeNews".localized
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.button(image: UIImage(named: "ic-back")!, title: "", target: self, action: #selector(self.callCustomAction))
        self.backButton.setImage(UIImage(named: "ic-back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.backButton.tintColor = AppColors.textBlack
        self.presenter?.initDataPresent()
        self.configureTableView()
    }
    @objc func callCustomAction() {
        self.backToPrevToVC(with: CustomerHomeViewController.self)
    }

    override func viewWillAppear(_ animated: Bool) { // As soon as vc appears
        super.viewWillAppear(true)

        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) { // As soon as vc disappears
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func configureTableView() {
        dataSource = TableDataSource<ViewCustomerHomeNews, CellViewCustomerHomeNews, CellDataCustomerHomeNews>.init(.MultipleSection(items: self.items), tableView, false)
        //            dataSource?.refreshProgrammatically()

        dataSource?.configureCell = { (cell, item, indexPath) in
            if indexPath.section == 0 {
                (cell as? TextCustomerHomeNewsDetailTableViewCell)?.item = item
//                (cell as? HomeCustomTableViewCell)?.selectedData = { (selected) in
//                    self.openChildScreen(.CustomerHomeAppointmentViewController, fromStoryboard: .CustomerHome, withContext: RouteContext([RVContext:selected]))
//                }
            } else {
                (cell as? ListCustomerHomeNewsDetailTableViewCell)?.item = item
//                (cell as? NewsCustomTableViewCell)?.selectedData = { (selected) in
//                    self.openChildScreen(.CustomerHomeNewsViewController, fromStoryboard: .CustomerHome, withContext: RouteContext([RVContext:selected]))
//                }
            }
        }

        dataSource?.addPullToRefresh = { [weak self] in
//            self?.resetData()
//            self?.presenter?.initDataPresent()
        }

        dataSource?.addInfiniteScrolling = { [weak self] (page) in
            //            self?.presenter?.requestData.keyWord = self?.searchText ?? ""
//            self?.presenter?.requestData.pageNum = page
//            self?.presenter?.socialQuestionService()
        }
        dataSource?.didSelectRow = { (indexPath, item) in
            if indexPath.section > 0 {
                if let model = item?.property?.model {
                    self.openChildScreen(.CustomerHomeNewsViewController, fromStoryboard: .CustomerHome, withContext: RouteContext(["RVContextDetail":model.newsRe]))
                }
            }
        }
    }
    @IBAction func backButton(_ sender: Any) {
        self.backToPrevScreen()
    }

    // MARK: - Update Data IBOutlet
    func updateData(data: ViewCustomerHomeNews) {

    }
    
    // MARK: - Action Button
    
}

// MARK: - Protocol of Presenter
extension CustomerHomeNewsViewController: CustomerHomeNewsVC {
    func initData(data: [ViewCustomerHomeNews]) {
//        if data.count == 0 {
//            if self.items.count > 0 {
//                self.dataSource?.updateAndReload(for: .MultipleSection(items: self.items), .Complete)
//            } else {
//                //Show tableview empty
//                self.dataSource?.updateAndReload(for: .MultipleSection(items: self.items), .FullReload)
//            }
//        } else {
//            self.items.append(contentsOf:  data)
        self.items.removeAll()
        self.items = data
        self.dataSource?.updateAndReload(for: .MultipleSection(items: self.items), .FullReload)
//        }
    }

    func reloadData() {
        self.dataSource?.stopInfiniteLoading(.FinishLoading)
    }

    func resetData() {
        self.items.removeAll()
    }
}


