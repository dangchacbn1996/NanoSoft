//
//  HospitalMainViewController.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 15/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit
import ActionSheetPicker_3_0

protocol HospitalMainCellDelegate {
    func reloadLayoutTable(handler: () -> (Void))
}

class HospitalMainViewController: BaseViewController<HospitalHomePresenter> {
    private let scrollMain = UIScrollView()
    private let stackMain = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .center, spacing: 8)
    
    private var tableView: UITableView!
    private var phoneLabel = UILabel(text: "", font: UIFont.customNormal14, color: .white)
//    private var appointmentButton: UIButton!
//    private var callButton: UIButton!
    
    var items: [ViewHospitalMain] = []
    private var dataSource: TableDataSource<ViewHospitalMain,
                                            CellViewHospitalMain,
                                            CellDataHospitalMain>?
    
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = HospitalHomePresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
        self.presenter?.initDataPresent()
//        self.defaultNavigation()
        
        self.configureTableView()
//        self.phoneLabel.text = Common.BRAND_PHONE_NUMBER
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func defaultNavigation() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = .boldSystemFont(ofSize: 17.0.auto())
        let fullName = UserDefaults.standard.df.fetch(forKey: String(describing: CustomerProfileOptionalResponse.self), type: CustomerProfileOptionalResponse.self)?.hoTen ?? ""
        label.text = Common.IS_GUEST ? "  Khách hàng" : "  " + fullName
        
        let images = UIImageView()
        images.widthAnchor.constraint(equalToConstant: 40.auto()).isActive = true
        images.heightAnchor.constraint(equalToConstant: 40.auto()).isActive = true
        
        let urlImage = UserDefaults.standard.df.fetch(forKey: String(describing: CustomerProfileOptionalResponse.self), type: CustomerProfileOptionalResponse.self)?.anhKhachHang ?? ""
        images.avartaImageView(url: Common.stringToUrlImage(text: urlImage))
        images.layer.cornerRadius = 20
        images.clipsToBounds = true
        images.layer.borderWidth = 1.0
        images.layer.borderColor = UIColor.white.cgColor
        
        stackView.addArrangedSubview(images)
        stackView.addArrangedSubview(label)
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        stackView.addGestureRecognizer(gesture)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: stackView)
        self.navigationItem.titleView = nil
        self.rightMoreButtonNavigation()
    }
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        // Do what you want
        if Common.IS_GUEST {
            self.alertGuest()
        } else {
            self.openChildScreen(.CustomerProfileViewController, fromStoryboard: .CustomerHome)
        }
    }
    
    
    override func updatePanData(context: RouteContext) {
        super.updatePanData(context: context)
        //        print(context[RVBackContext])
        //        self.presenter?.updateBackContextData(context: context)
    }
    @IBAction func callButtonAction(_ sender: Any) {
        Common.callNumber(phoneNumber: Common.BRAND_PHONE_NUMBER)
    }
    
    @IBAction func appointmentButtonAction(_ sender: Any) {
        if Common.IS_GUEST {
            self.alertGuest()
        } else {
            self.openChildScreen(.CreateAppointmentViewController, fromStoryboard: .Appointment, withContext: RouteContext([:]))
        }
    }
    
    // MARK: - TableView Setup
    private func configureTableView() {
//        return
        dataSource = TableDataSource<ViewHospitalMain, CellViewHospitalMain, CellDataHospitalMain>.init(.MultipleSection(items: self.items), tableView, true)
        //            dataSource?.refreshProgrammatically()
        
        dataSource?.configureCell = { (cell, item, indexPath) in
            //CellIntro
            if indexPath.section == 0 {
                (cell as? HospitalIntroduceTableViewCell)?.selectedNotify = {
//                    self.openScreen(HospitalNotificationMainViewController())
                    self.navigationController?.pushViewController(HospitalNotificationMainViewController(), animated: true)
                }
            } else if indexPath.section == 1 {
                //Cell chonj bac si
                (cell as? HospitalBookingTableViewCell)?.item = item
                (cell as? HospitalBookingTableViewCell)?.delegate = self
                
//                (cell as? HospitalBookingTableViewCell)?.selectedData = { [weak self] (selected) in
//                    self?.openChildScreen(HospitalMainViewController(), withContext: RouteContext([RVContext:selected]))
//                }
                (cell as? HospitalBookingTableViewCell)?.bookingDoctor = { [weak self] (selected) in
                    self?.openChildScreen(.CreateAppointmentViewController, fromStoryboard: .Appointment, withContext: RouteContext(["RVContextDoctor":selected]))
                }
                
                (cell as? HospitalBookingTableViewCell)?.selectedMajor = { [weak self] (selected) in
                    self?.presenter?.getEmployeeByMajor(major: selected, success: { doctorlist in
//                        var newDocs: [ResponseDoctorByMajorModel] = []
//                        for _ in 0..<10 {
//                            newDocs.append(ResponseDoctorByMajorModel.demoData())
//                        }
                        (cell as? HospitalBookingTableViewCell)?.updateModel(model: doctorlist ?? [])
                    })
                }
                
            } else if indexPath.section == 2 {
                //Chon loai phong kham
                (cell as? HospitalProductTypeTableViewCell)?.item = item
                
//                self.openChildScreen(.CreateAppointmentViewController, fromStoryboard: .Appointment, withContext: RouteContext(["RVContextDoctor":model]))
                
                
                (cell as? HospitalProductTypeTableViewCell)?.selectedProduct = { [weak self] (selected) in
                    if selected.MaLoaiDichVu == "TTS" && !(self?.presenter?.isTTSAvailable() ?? true) {
                        HospitalService.showError(text: "Tài khoản của bạn không có quyền truy cập chức năng này") {
                            
                        }
                        return
                    }
                    if selected.IDLoaiDV == HospitalProductCollectionViewCell.INDEX_FILE {
                        if let url = URL(string: DataManager.shared.companyModel?.UrlTraKetQua ?? "") {
                             UIApplication.shared.openURL(url)
                         }
                        return
                    }
                    if selected.IDLoaiDV == HospitalProductCollectionViewCell.INDEX_COMMUTY {
                        (UIApplication.shared.keyWindow?.rootViewController as? HospitalMainTabbarViewController)?.selectedIndex = 2
                        return
                    }
                    if selected.MaLoaiDichVu == "KDN" {
                        self?.presenter?.getProductDetail(product: selected, success: { (list) in
                            self?.openChildScreen(HospitalListServiceViewController(), withContext: RouteContext(["RVContext":list, "RVTitle": selected.TenLoaiDichVu, "RVProduct": selected]))
                        })
                        return
                    }
//                    self?.presenter?.getProductDetail(product: selected, success: { (list) in
//                        self?.openChildScreen(HospitalListServiceViewController(), withContext: RouteContext(["RVContext":list, "RVTitle": selected.TenLoaiDichVu, "RVProduct": selected]))
                        self?.openChildScreen(.CreateAppointmentViewController, fromStoryboard: .Appointment, withContext:
                                                RouteContext([
                                                    CreateAppointmentPresenter.RV_PRODUCT_NAME : selected.TenLoaiDichVu,
                                                    CreateAppointmentPresenter.RV_PRODUCT_CODE : selected.MaLoaiDichVu
                                                ]))
//                    })
                }
            } else if indexPath.section == 3 {
                //Chon dich vu
                (cell as? HospitalServiceTableViewCell)?.item = item
                
                (cell as? HospitalServiceTableViewCell)?.selectedService = { [weak self] (selected) in
                    self?.openChildScreen(HospitalServiceListViewController(), withContext: RouteContext([HospitalServicePresenter.keyService:selected]))
//                    self?.presenter?.getServiceDetail(service: selected, success: { (list) in
//                        self?.openChildScreen(HospitalServiceListViewController(), withContext: RouteContext([HospitalServicePresenter.keyService:list]))
//                    })
                }
            } else if indexPath.section == 4 {
                (cell as? HospitalNewsTableViewCell)?.item = item
                (cell as? HospitalNewsTableViewCell)?.btnMore.addAction(for: .touchUpInside, closure: { [weak self](action) in
                    self?.openChildScreen(.CustomerHomeNewsFilterViewController, fromStoryboard: .CustomerHome, withContext: RouteContext([:]))
                })
                (cell as? HospitalNewsTableViewCell)?.selectedData = { [weak self] (selected) in
                    self?.openChildScreen(.CustomerHomeNewsViewController, fromStoryboard: .CustomerHome, withContext: RouteContext([RVContext:selected]))
                }
                if let content = (cell as? HospitalNewsTableViewCell)?.contentView {
                    (cell as? HospitalNewsTableViewCell)?.bringSubviewToFront(content)
                }
            } else if indexPath.section == 5 {
                (cell as? HospitalContactTableViewCell)?.item = item
            }
        }
        
        dataSource?.addPullToRefresh = { [weak self] in
            self?.presenter?.initDataPresent()
        }
        
        dataSource?.addInfiniteScrolling = { [weak self] (page) in
            //            self?.presenter?.requestData.keyWord = self?.searchText ?? ""
            //            self?.presenter?.requestData.pageNum = page
            //            self?.presenter?.socialQuestionService()
        }
//        dataSource?.didSelectRow = nil
//        dataSource?.didSelectRow = { (indexPath, item) in
//            if let model = item?.property?.model {
                //                self.openChildScreen(.CustomerDetailViewController, fromStoryboard: .Home, withContext: RouteContext([RVContext: model]))
//            }
//        }
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewCustomerHome) {
        
    }
    
    private func setupUI() {
        self.view.setLinearGradient(startColor: AppColors.gradientStart, endColor: UIColor.white)
//        self.edgesForExtendedLayout = .top
        
        tableView = UITableView()
//        self.view.addSubview(tableView)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints({
            $0.centerX.width.bottom.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
        })
//        self.tableView.delegate = dataSource
//        self.tableView.dataSource = dataSource
        self.tableView.register(HospitalNewsTableViewCell.self, forCellReuseIdentifier: HospitalNewsTableViewCell.id)
        self.tableView.register(HospitalBookingTableViewCell.self, forCellReuseIdentifier: HospitalBookingTableViewCell.id)
        self.tableView.register(HospitalProductTypeTableViewCell.self, forCellReuseIdentifier: HospitalProductTypeTableViewCell.id)
        self.tableView.register(HospitalIntroduceTableViewCell.self, forCellReuseIdentifier: HospitalIntroduceTableViewCell.id)
        self.tableView.register(HospitalServiceTableViewCell.self, forCellReuseIdentifier: HospitalServiceTableViewCell.id)
        self.tableView.register(HospitalContactTableViewCell.self, forCellReuseIdentifier: HospitalContactTableViewCell.id)
        self.tableView.backgroundColor = UIColor.white
        self.tableView.delaysContentTouches = true
        self.tableView.canCancelContentTouches = true
        self.tableView.allowsMultipleSelection = false
        self.tableView.separatorStyle = .none
        self.tableView.contentInsetAdjustmentBehavior = .never
//        self.tableView.tableHeaderView = nil
        self.tableView.bounces = false
        
//        tableView.roundCorners([.topLeft, .topRight], radius: 20)
        tableView.contentInset = UIEdgeInsets(top: -22, left: 0, bottom: 20, right: 0)
        
    }
    
    // MARK: - Action Button
}

extension HospitalMainViewController: HospitalMainCellDelegate {
    func reloadLayoutTable(handler: () -> (Void)) {
        tableView.beginUpdates()
        handler()
        tableView.endUpdates()
    }
    
}

// MARK: - Protocol of Presenter
extension HospitalMainViewController: HospitalHomeVC {
    func initData(data: [ViewHospitalMain]) {
        self.items.removeAll()
        self.items = data
        self.dataSource?.updateAndReload(for: .MultipleSection(items: self.items), .FullReload)
    }
    
    func reloadData() {
        self.dataSource?.stopInfiniteLoading(.FinishLoading)
    }
    
    func resetData() {
        self.items.removeAll()
    }
}
