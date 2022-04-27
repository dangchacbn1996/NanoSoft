//
//  HospitalServiceListViewController.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 30/08/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

class HospitalServiceListViewController: BaseViewController<HospitalServicePresenter> {
    
    var data: SuggestionCustomerHomeOptionalResponse?
    
    private var tfSearch = UITextField(text: "", placeholder: "Tìm kiếm", font: UIFont.customOpenSans(12), color: AppColors.textBlack)
    private var tblData = UITableView()
        
    override func initPresenter(with context: RouteContext?) {
//        super.initPresenter(with: context)
        presenter = HospitalServicePresenter()
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
        
    }
    
    @objc private func actCreateOrder() {
        if let combo = presenter?.serviceCode {
            self.openChildScreen(.CreateAppointmentViewController, fromStoryboard: .Appointment, withContext: RouteContext([CreateAppointmentPresenter.RV_COMBO_SERVICE:combo]))
        }
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewCustomerHome) {
        
    }
}

// MARK: - Protocol of Presenter
extension HospitalServiceListViewController: HospitalServiceVC {
    
    func reloadCombo() {
        self.title = presenter?.serviceCode?.TenComboGoiDVSP ?? "Chi tiết gói"
    }
    
    func reloadData() {
        tblData.reloadData()
    }
    
    private func actSearch() {
        presenter?.getServiceList(key: tfSearch.text ?? "")
//        presenter?.getProductDetail(textSearch: tfSearch.text ?? "")
    }
}

extension HospitalServiceListViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        actSearch()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension HospitalServiceListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HospitalServiceListTableViewCell.self), for: indexPath) as! HospitalServiceListTableViewCell
        cell.data = presenter?.serviceList[indexPath.row] ?? nil
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.serviceList.count ?? 0
    }
}

extension HospitalServiceListViewController {
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
        
        self.tblData.backgroundColor = UIColor.white
//        self.tblData.allowsSelection = true
        self.tblData.separatorStyle = .none
        self.tblData.tableHeaderView = nil
        self.tblData.bounces = false
        self.tblData.delegate = self
        self.tblData.dataSource = self
        self.tblData.register(HospitalServiceListTableViewCell.self, forCellReuseIdentifier: String(describing: HospitalServiceListTableViewCell.self))
        
//        tableView.roundCorners([.topLeft, .topRight], radius: 20)
        self.tblData.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
}

class HospitalServiceListTableViewCell: UITableViewCell {
    private let imAdv = UIImageView()
    private let lbName = UILabel(font: UIFont.customOpenSans(14, .semiBold), color: AppColors.textBlack, breakable: true)
    
    var data: ResponseComboDetailModel? = nil {
        didSet {
            lbName.text = data?.TenDichVu ?? "-"
            imAdv.pictureSquareImageView(url: Common.stringToUrlImage(text: data?.AnhDichVu ?? ""))
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let vContainer = CardView()
        self.contentView.addSubview(vContainer)
        vContainer.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().offset(-32)
            $0.height.equalToSuperview().offset(-16)
        })
        vContainer.backgroundColor = .white
        vContainer.cornerradius = 6
//        vContainer.dropShadow()
        vContainer.addSubview(imAdv)
        imAdv.snp.makeConstraints({
            $0.centerY.leading.top.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.25)
        })
        imAdv.contentMode = .scaleAspectFill
        imAdv.clipsToBounds = true
        
        vContainer.addSubview(lbName)
        lbName.snp.makeConstraints({
            $0.top.equalToSuperview().offset(4)
            $0.leading.equalTo(imAdv.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().offset(8)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
