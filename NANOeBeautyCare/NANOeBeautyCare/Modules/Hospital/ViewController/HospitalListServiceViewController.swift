//
//  HospitalListServiceViewController.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 19/05/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

class HospitalListServiceViewController: BaseViewController<HospitalListServicePresenter> {
    
    private var dataSource: TableDataSource<ViewHeadFootServiceProvider, CellServiceProvider, CellServiceHospitalMain>?
    
    private var tfSearch = UITextField(text: "", placeholder: "Tìm kiếm", font: UIFont.customOpenSans(12), color: AppColors.textBlack)
    private var tblData = UITableView()
    private let lbCountSelected = UILabel(text: "", font: UIFont.customOpenSans(12), color: .white, breakable: false)
    var items: [ViewHeadFootServiceProvider] = []
    var selected: [ResponseProductListSubModel] = [] {
        didSet {
            lbCountSelected.alpha = self.selected.count == 0 ? 0 : 1
            lbCountSelected.text = "\(self.selected.count)"
        }
    }
    
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = HospitalListServicePresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.configureTableView()
        presenter?.initDataPresenter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func configureTableView() {
        dataSource = TableDataSource<ViewHeadFootServiceProvider, CellServiceProvider, CellServiceHospitalMain>.init(.MultipleSection(items: self.items), tblData, true)
        //            dataSource?.refreshProgrammatically()
        
        dataSource?.configureCell = { (cell, item, indexPath) in
            if indexPath.section == 0 {
//                (cell as? HospitalContactInfoTableViewCell).select
            }
            if indexPath.section == 1 {
//                (cell as? HospitalServiceItem)?.selectionStyle = .gray
                (cell as? HospitalServiceItem)?.data = item
                (cell as? HospitalServiceItem)?.showDetail = {
                    if let model = item?.property?.model?.serviceList {
//                        self.presenter?.showDetail(data: model, success: { result in
                            self.openChildScreen(HospitalServiceListViewController(), withContext: RouteContext([HospitalServicePresenter.keyProduct : model]))
//                        })
                    }
                }
                (cell as? HospitalServiceItem)?.isChecked = {[weak self] (selected) in
                    if selected {
                        if let model = item?.property?.model?.serviceList {
                            self?.selected.append(model)
                        }
                    } else {
                        if let model = item?.property?.model?.serviceList {
                            self?.selected.removeObject(model)
                        }
                    }
                }
                (cell as? HospitalServiceItem)?.bringSubviewToFront((cell as? HospitalServiceItem)!.btnSelect)
                
            }
        }
        
        dataSource?.addPullToRefresh = { [weak self] in
            self?.presenter?.initDataPresenter()
        }
        
//        dataSource?.addInfiniteScrolling = { [weak self] (page) in
//            //            self?.presenter?.requestData.keyWord = self?.searchText ?? ""
//            //            self?.presenter?.requestData.pageNum = page
//            //            self?.presenter?.socialQuestionService()
//        }
//        dataSource?.didSelectRow = nil
//        dataSource?.didSelectRow = { (indexPath, item) in
//            if let model = item?.property?.model {
                //                self.openChildScreen(.CustomerDetailViewController, fromStoryboard: .Home, withContext: RouteContext([RVContext: model]))
//            }
//        }
    }
    
    @objc private func actCreateOrder() {
        self.openChildScreen(.CreateAppointmentViewController, fromStoryboard: .Appointment, withContext: RouteContext([CreateAppointmentPresenter.RV_LIST_SERVICE:selected]))
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewCustomerHome) {
        
    }
}

extension HospitalListServiceViewController: HospitalMainCellDelegate {
    func reloadLayoutTable(handler: () -> (Void)) {
        tblData.beginUpdates()
        handler()
        tblData.endUpdates()
    }
    
}

// MARK: - Protocol of Presenter
extension HospitalListServiceViewController: HospitalListServiceVC {
    func initData(data: [ViewHeadFootServiceProvider]) {
        self.title = presenter?.titleText ?? "Dịch vụ"
        self.items.removeAll()
        self.items = data
        self.dataSource?.updateAndReload(for: .MultipleSection(items: self.items), .FullReload)
    }
    
    func reloadData() {
//        self.dataSource?.updateAndReload(for: .MultipleSection(items: self.items), .FullReload)
        self.dataSource?.stopInfiniteLoading(.FinishLoading)
    }
    
    func resetData() {
        self.items.removeAll()
    }
    
    private func actSearch() {
        presenter?.getProductDetail(textSearch: tfSearch.text ?? "")
    }
}

extension HospitalListServiceViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        actSearch()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension HospitalListServiceViewController {
    private func setupUI() {
        self.view.setLinearGradient(startColor: AppColors.gradientMid, endColor: AppColors.gradientEnd)
        
        let vRightNavi = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let imRight = UIImageView(image: UIImage(named: "ic-sale-unselected-tabbar")?.withRenderingMode(.alwaysTemplate))
        vRightNavi.addSubview(imRight)
        imRight.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        imRight.tintColor = .white
        imRight.contentMode = .scaleAspectFit
        
        vRightNavi.addSubview(lbCountSelected)
        lbCountSelected.snp.makeConstraints({
            $0.top.trailing.equalToSuperview()
            $0.size.equalTo(16)
        })
        lbCountSelected.backgroundColor = AppColors.viewRed
        lbCountSelected.layer.cornerRadius = 8
        lbCountSelected.textAlignment = .center
        lbCountSelected.alpha = 0
        lbCountSelected.clipsToBounds = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: vRightNavi)
        vRightNavi.isUserInteractionEnabled = true
        vRightNavi.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.actCreateOrder)))
        
        let vSearch = UIView()
        self.view.addSubview(vSearch)
        vSearch.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(16)
            $0.height.equalTo(24)
            $0.width.equalToSuperview().offset(-32)
        })
        vSearch.backgroundColor = .white
        vSearch.clipsToBounds = true
        vSearch.layer.cornerRadius = 4
        let icSearch = UIImageView(image: UIImage(named: "ic-search")?.withRenderingMode(.alwaysTemplate))
        icSearch.tintColor = AppColors.gray
        vSearch.addSubview(icSearch)
        icSearch.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.height.equalToSuperview().offset(-8)
            $0.leading.equalToSuperview().offset(8)
            $0.width.equalTo(icSearch.snp.height)
        })
        icSearch.contentMode = .scaleAspectFit
        
        vSearch.addSubview(tfSearch)
        tfSearch.snp.makeConstraints({
            $0.centerY.height.equalToSuperview()
            $0.leading.equalTo(icSearch.snp.trailing).offset(6)
            $0.trailing.equalToSuperview().offset(-8)
        })
        tfSearch.delegate = self
        tfSearch.returnKeyType = .done
        
        self.view.addSubview(tblData)
        tblData.snp.makeConstraints({
            $0.centerX.width.bottom.equalToSuperview()
            $0.top.equalTo(vSearch.snp.bottom).offset(16)
        })
        tblData.backgroundColor = .white
        tblData.register(HospitalServiceItem.self, forCellReuseIdentifier: HospitalServiceItem.id)
        tblData.register(HospitalContactInfoTableViewCell.self, forCellReuseIdentifier: HospitalContactInfoTableViewCell.id)
        tblData.dataSource = dataSource
        
        self.tblData.backgroundColor = UIColor.white
//        self.tblData.allowsSelection = true
        self.tblData.separatorStyle = .none
        self.tblData.tableHeaderView = nil
        self.tblData.bounces = false
        
//        tableView.roundCorners([.topLeft, .topRight], radius: 20)
        self.tblData.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
}

class HospitalServiceItem: UITableViewCell {
    
    static let id = "HospitalServiceItem"
    
    private let imImage = UIImageView()
    private let lbTitle = UILabel(text: "", font: .customOpenSans(14, .semiBold), color: AppColors.textBlack, breakable: true)
    private let lbContent = UILabel(text: "", font: .customOpenSans(14, .regular), color: AppColors.textBlack, breakable: true)
    private let lbPrice = UILabel(text: "", font: .customOpenSans(14), color: AppColors.textBlue, breakable: true)
    private let lbDiscount = UILabel(text: "", font: .customOpenSans(14), color: AppColors.textBlack, breakable: true)
    private let btnDetail = UIButton()
    let btnSelect = SelectableButton()
    var isChecked: ((Bool) -> ())? = nil
    var showDetail: (() -> Void)? = nil
    var data: CellServiceProvider? = nil {
        didSet {
            lbTitle.text = data?.property?.model?.serviceList.TenDichVu ?? ""
            imImage.pictureSquareImageView(url: Common.stringToUrlImage(text: data?.property?.model?.serviceList.AnhDichVu ?? ""))
            lbPrice.text = data?.property?.model?.serviceList.DonGia?.formatnumberWithCurrency() ?? ""
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func actSelectedDetail() {
        self.showDetail?()
    }
    
    @objc private func actSelectedButton() {
        btnSelect.setChecked(!btnSelect.isSelected)
        isChecked?(btnSelect.isSelected)
    }
    
    private func setupUI() {
        let vContainer = CardView()
        vContainer.backgroundColor = .white
        
        self.contentView.addSubview(vContainer)
        vContainer.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-16)
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().offset(-32)
        })
        vContainer.shadowColors = .gray
        vContainer.layer.cornerRadius = 10
        vContainer.clipsToBounds = true
//        vContainer.isUserInteractionEnabled = true
//        vContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.actSelectedButton)))
        
        vContainer.addSubview(imImage)
        imImage.snp.makeConstraints({
            $0.centerY.height.leading.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.25)
        })
        imImage.clipsToBounds = true
        imImage.contentMode = .scaleAspectFill
        
        vContainer.addSubview(lbTitle)
        lbTitle.snp.makeConstraints({
            $0.top.equalToSuperview().offset(4)
            $0.leading.equalTo(imImage.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().offset(8)
        })
        
        vContainer.addSubview(lbContent)
        lbContent.snp.makeConstraints({
            $0.centerX.width.equalTo(lbTitle)
            $0.top.equalTo(lbTitle.snp.bottom).offset(4)
        })
        
        let vPrice = UIView()
        vContainer.addSubview(vPrice)
        vPrice.snp.makeConstraints({
            $0.centerX.width.equalTo(lbTitle)
            $0.top.equalTo(lbContent.snp.bottom).offset(10)
        })
        vPrice.addSubview(lbPrice)
        lbPrice.snp.makeConstraints({
            $0.centerY.height.leading.equalToSuperview()
        })
        vPrice.addSubview(lbDiscount)
        lbDiscount.snp.makeConstraints({
            $0.centerY.height.equalToSuperview()
            $0.leading.greaterThanOrEqualTo(vPrice.snp.centerX)
            $0.leading.greaterThanOrEqualTo(lbPrice.snp.trailing).offset(4)
        })
        
        let vAction = UIView()
        vContainer.addSubview(vAction)
        vAction.snp.makeConstraints({
            $0.centerX.width.equalTo(lbTitle)
            $0.top.greaterThanOrEqualTo(vPrice.snp.bottom).offset(5)
            $0.bottom.equalToSuperview().offset(-5)
            $0.height.equalTo(28)
        })
        
        vAction.addSubview(btnDetail)
        btnDetail.snp.makeConstraints({
            $0.leading.centerY.height.equalToSuperview()
            $0.width.equalTo(94)
        })
        btnDetail.layer.cornerRadius = 14
        btnDetail.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        btnDetail.setTitle("Chi tiết", for: .normal)
        btnDetail.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.actSelectedDetail)))
        
        
        vAction.addSubview(btnSelect)
        btnSelect.snp.makeConstraints({
            $0.centerY.height.equalTo(btnDetail)
            $0.leading.equalTo(btnDetail.snp.trailing).offset(8)
            $0.size.equalTo(btnDetail)
        })
        btnSelect.addChecked()
        btnSelect.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        btnSelect.layer.cornerRadius = btnDetail.layer.cornerRadius
        btnSelect.setTitle("Chọn", for: .normal)
//        btnSelect.isEnabled = true
        btnSelect.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.actSelectedButton)))
    }
}
