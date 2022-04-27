//
//  DetailTreatmentViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/30/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class DetailTreatmentViewController: BaseViewController<DetailTreatmentPresenter> {
    // MARK: - IBOutlet
    @IBOutlet weak var statusImageview: UIImageView!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var numberTextfield: MyTextField!
    
    @IBOutlet weak var cardTableView: CardView!
    @IBOutlet weak var moreHorizonralImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    let alertCustomer = AlertTwoTreatmentButtonViewController()
    var resetData: Bool?
    
    var items: [DetailTreatmentOptionalResponse] = []
    private var pageNo:UInt = 1
    private var dataSource: TableDataSource<DefaultHeaderFooterModel<DetailTreatmentOptionalResponse>,
                                            DefaultCellModel<DetailTreatmentOptionalResponse>,
                                            DetailTreatmentOptionalResponse>?
    
    
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = DetailTreatmentPresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.presenter?.initDataPresent()
        self.backButtonNavigation()
        self.configureTableView()
    }
    
    override func updatePanData(context: RouteContext) {
        super.updatePanData(context: context)
        
        self.resetData = context[RVBackContext]
        if self.resetData == true {
            self.pageNo = 1
            self.items.removeAll()
            self.dataSource?.updateAndReload(for: .SingleListing(items: self.items), .FullReload)
            self.presenter?.callService()
        }
    }
    
    // MARK: - TableView Setup
    private func configureTableView() {
        dataSource = TableDataSource<DefaultHeaderFooterModel<DetailTreatmentOptionalResponse>, DefaultCellModel<DetailTreatmentOptionalResponse>, DetailTreatmentOptionalResponse>.init(.SingleListing(items: items, identifier: DetailTreatmentTableViewCell.identfier, height: UITableView.automaticDimension, leadingSwipe: nil, trailingSwipe: nil), tableView)
        //            dataSource?.refreshProgrammatically()
        
        dataSource?.configureCell = { [weak self] (cell, item, indexPath) in
            (cell as? DetailTreatmentTableViewCell)?.item = item
            (cell as? DetailTreatmentTableViewCell)?.moreButton.addAction(for: .touchUpInside, closure: { (button) in
                self?.alertCustomer.dataModel = item?.property?.model
                self?.alertCustomer.show()
                
                self?.alertCustomer.callButton.addAction(for: .touchUpInside, closure: {  [weak self] (button) in
                    self?.alertCustomer.dismiss()
                    self?.openChildScreen(.TreatmentEditDetailViewController, fromStoryboard: .Treatment, withContext: RouteContext([RVContext:item?.property?.model]))
                })
                
                self?.alertCustomer.messageButton.addAction(for: .touchUpInside, closure: {  [weak self] (button) in
                    self?.alertCustomer.dismiss()
                    self?.openChildScreen(.TreatmentReportViewController, fromStoryboard: .Treatment, withContext: RouteContext([RVContext:item?.property?.model]))
                })
            })
        }
        
        dataSource?.addPullToRefresh = { [weak self] in
            self?.pageNo = 1
            self?.items.removeAll()
            self?.presenter?.callService()
        }
        
        dataSource?.addInfiniteScrolling = { [weak self] (page) in
            //            self?.pageNo = (self?.pageNo ?? 0) + 1
            //            self?.presenter?.customerPortfolioService(keyword: self?.searchText ?? "",page: self?.pageNo ?? 1)
        }
        dataSource?.didSelectRow = { (indexPath, item) in
            //            self.openChildScreen(.CustomerDetailViewController, fromStoryboard: .Home, withContext: RouteContext([RVContext: item?.property?.model]))
        }
        
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewDetailTreatment) {
        
    }
    
    // MARK: - Action Button
    @IBAction func closeButtonAction(_ sender: Any) {
        self.cardTableView.isHidden = !self.cardTableView.isHidden
        
        if self.cardTableView.isHidden == true {
            self.moreHorizonralImageView.image = UIImage(named: "more-horizontal-collapse")
        } else {
            self.moreHorizonralImageView.image  = UIImage(named: "more-horizontal-expand")
        }
    }
    
}

// MARK: - Protocol of Presenter
extension DetailTreatmentViewController: DetailTreatmentVC {
    func initData(data: [DetailTreatmentOptionalResponse]) {
        self.dataSource?.updateAndReload(for: .SingleListing(items: data), .FullReload)
    }
    
    func updateHeaderData(data: TreatmentOptionalResponse) {
        self.title = data.hoTen
        self.numberTextfield.text = data.soLuongDaThucHien
        
        let (textStatus, imageStatus) = Common.statusWithColor(statusNumber: data.trangThaiDieuTri ?? 0)
        self.statusImageview.image = imageStatus
        self.statusLabel.text = data.trangThaiDieuTriText
        self.titleLabel.text = data.tenDichVu
    }
    func reloadData() {
        self.dataSource?.stopInfiniteLoading(.FinishLoading)
    }
}


