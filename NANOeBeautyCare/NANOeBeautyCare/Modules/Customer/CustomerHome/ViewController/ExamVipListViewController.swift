//
//  ExamVipListViewController.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 03/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

class ExamVipListViewController: BaseViewController<ExamVipListPresenter> {
    
    private let lbCount = UILabel(font: .systemFont(ofSize: 10, weight: .regular), color: .white)
    private let tfSearch = UITextField(placeholder: "Tìm kiếm ...", font: .systemFont(ofSize: 16, weight: .semibold), color: .white)
    private var items: [ViewCustomerHome] = []
    private let tbvListService = UITableView()
    private var dataSource: TableDataSource<ViewCustomerHome,
                                            CellViewCustomerHome,
                                            CellDataCustomerHome>?
    
    override func initPresenter(with context: RouteContext?) {
        presenter = ExamVipListPresenter()
//        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Khám TTS VIP"
        self.presenter?.initDataPresent()
        self.edgesForExtendedLayout = UIRectEdge()
        setupUI()
        configureTableView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.navigationController?.navigationItem.rightBarButtonItem = nil
    }
    
    func initData(data: [ViewCustomerHome]) {
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
    
    private func configureTableView() {
        self.tbvListService.register(ExamListTableViewCell.self, forCellReuseIdentifier: ExamListTableViewCell.id)
        dataSource = TableDataSource<ViewCustomerHome, CellViewCustomerHome, CellDataCustomerHome>.init(.MultipleSection(items: self.items), self.tbvListService, true)
        //            dataSource?.refreshProgrammatically()
        
        dataSource?.configureCell = { (cell, item, indexPath) in
//            if indexPath.section == 0 {
                (cell as? ExamListTableViewCell)?.item = item
//                (cell as? ExamListTableViewCell)?.moreButton.addAction(for: .touchUpInside, closure: { [weak self](action) in
//                    self?.openChildScreen(.CustomerHomeFilterViewController, fromStoryboard: .CustomerHome, withContext: RouteContext([:]))
                }
        
        dataSource?.addPullToRefresh = { [weak self] in
//            self?.presenter?.initDataPresent()
        }
        
        dataSource?.addInfiniteScrolling = { [weak self] (page) in
            //            self?.presenter?.requestData.keyWord = self?.searchText ?? ""
            //            self?.presenter?.requestData.pageNum = page
            //            self?.presenter?.socialQuestionService()
        }
        dataSource?.didSelectRow = { (indexPath, item) in
            if let model = item?.property?.model {
                //                self.openChildScreen(.CustomerDetailViewController, fromStoryboard: .Home, withContext: RouteContext([RVContext: model]))
            }
        }
    }
    
//    // MARK: - TableView Setup
//    private func configureTableView() {
//        dataSource = TableDataSource<DefaultHeaderFooterModel<SuggestionCustomerHomeOptionalResponse>, DefaultCellModel<SuggestionCustomerHomeOptionalResponse>, SuggestionCustomerHomeOptionalResponse>.init(.SingleListing(items: items, identifier: CustomerHomeFilterTableViewCell.identfier, height: 265.0.auto(), leadingSwipe: nil, trailingSwipe: nil), tableView)
//        //            dataSource?.refreshProgrammatically()
//
//        dataSource?.configureCell = { (cell, item, indexPath) in
//            (cell as? CustomerHomeFilterTableViewCell)?.item = item
//            (cell as? CustomerHomeFilterTableViewCell)?.appointmentButton.addAction(for: .touchUpInside, closure: { (button) in
//                if Common.IS_GUEST {
//                    self.alertGuest()
//                } else {
//                    self.openChildScreen(.CreateAppointmentViewController, fromStoryboard: .Appointment, withContext: RouteContext(["RVContextCustomer":item?.property?.model]))
//                }
//            })
//        }
//
//        dataSource?.addPullToRefresh = { [weak self] in
//            self?.resetData()
//            self?.presenter?.orginSerivce()
//        }
//
//        dataSource?.addInfiniteScrolling = { [weak self] (page) in
//            self?.presenter?.requestSuggestionCustomer.tenDichVu = self?.searchText ?? ""
//            self?.presenter?.requestSuggestionCustomer.pageNum = page
//            self?.presenter?.services()
//        }
//        dataSource?.didSelectRow = { (indexPath, item) in
//            if let model = item?.property?.model {
////                self.openChildScreen(.CustomerDetailViewController, fromStoryboard: .Home, withContext: RouteContext([RVContext: model]))
//                self.openChildScreen(.CustomerHomeAppointmentViewController, fromStoryboard: .CustomerHome, withContext: RouteContext([RVContext:model]))
//            }
//        }
//    }
}

extension ExamVipListViewController {
    private func setupUI() {
        let btnNews = UIButton()
        btnNews.setImage(UIImage(named: AssetsName.btnBack), for: .normal)
        btnNews.addSubview(lbCount)
        lbCount.snp.makeConstraints({
            $0.top.trailing.equalToSuperview()
            $0.size.equalTo(10)
        })
        lbCount.layer.cornerRadius = 3
        lbCount.backgroundColor = AppColors.viewRed
        lbCount.text = "2"
        lbCount.textAlignment = .center
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btnNews)
//        self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btnNews)
        
        let vSearch = UIView()
        self.view.addSubview(vSearch)
        vSearch.snp.makeConstraints({
            $0.top.equalToSuperview().offset(8)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().offset(-16)
            $0.height.equalTo(36)
        })
        vSearch.layer.cornerRadius = 3
        vSearch.layer.borderWidth = 1
        vSearch.layer.borderColor = UIColor.white.cgColor
        
        
        let ivSearch = UIImageView(image: UIImage(named: ""))
        vSearch.addSubview(ivSearch)
        ivSearch.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.size.equalTo(vSearch.snp.height).offset(-8)
            $0.leading.equalToSuperview().offset(4)
        })
        vSearch.addSubview(tfSearch)
        tfSearch.snp.makeConstraints({
            $0.centerY.height.equalToSuperview()
            $0.leading.equalTo(ivSearch.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().offset(-8)
        })
        
        let vContainer = UIView()
        vContainer.backgroundColor = .white
        self.view.addSubview(vContainer)
        vContainer.snp.makeConstraints({
            $0.top.equalTo(vSearch.snp.bottom).offset(8)
            $0.centerX.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        })
        vContainer.addSubview(tbvListService)
//        tbvListService.delegate = self
//        tbvListService.dataSource = self
        tbvListService.register(ExamListTableViewCell.self, forCellReuseIdentifier: ExamListTableViewCell.id)
    }
}
