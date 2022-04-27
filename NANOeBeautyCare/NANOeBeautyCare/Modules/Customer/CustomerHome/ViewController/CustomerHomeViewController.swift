//
//  CustomerHomeViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/22/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CustomerHomeViewController: BaseViewController<CustomerHomePresenter> {
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var appointmentButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    
    var items: [ViewCustomerHome] = []
    private var dataSource: TableDataSource<ViewCustomerHome,
                                            CellViewCustomerHome,
                                            CellDataCustomerHome>?
    
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = CustomerHomePresenter()
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
        self.phoneLabel.text = Common.BRAND_PHONE_NUMBER
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
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
        dataSource = TableDataSource<ViewCustomerHome, CellViewCustomerHome, CellDataCustomerHome>.init(.MultipleSection(items: self.items), tableView, true)
        //            dataSource?.refreshProgrammatically()
        
        dataSource?.configureCell = { (cell, item, indexPath) in
            if indexPath.section == 0 {
                (cell as? HomeCustomTableViewCell)?.item = item
                (cell as? HomeCustomTableViewCell)?.moreButton.addAction(for: .touchUpInside, closure: { [weak self](action) in
                    self?.openChildScreen(.CustomerHomeFilterViewController, fromStoryboard: .CustomerHome, withContext: RouteContext([:]))
                })
                (cell as? HomeCustomTableViewCell)?.selectedData = { [weak self] (selected) in
                    self?.openChildScreen(.CustomerHomeAppointmentViewController, fromStoryboard: .CustomerHome, withContext: RouteContext([RVContext:selected]))
                }
                
//                (cell as? HomeCustomTableViewCell)?.selectedData = { [weak self] (selected) in
//                    self?.openChildScreen(ExamVipListViewController(), withContext: RouteContext([RVContext:selected]))
//                    self?.openChildScreen(HospitalMainViewController(), withContext: RouteContext([RVContext:selected]))
//                }
                
            } else if indexPath.section == 1 {
                (cell as? NewsCustomTableViewCell)?.item = item
                (cell as? NewsCustomTableViewCell)?.moreButton.addAction(for: .touchUpInside, closure: { [weak self](action) in
                    self?.openChildScreen(.CustomerHomeNewsFilterViewController, fromStoryboard: .CustomerHome, withContext: RouteContext([:]))
                })
                (cell as? NewsCustomTableViewCell)?.selectedData = { [weak self] (selected) in
                    self?.openChildScreen(.CustomerHomeNewsViewController, fromStoryboard: .CustomerHome, withContext: RouteContext([RVContext:selected]))
                }
            } else {
                (cell as? AgencyCustomTableViewCell)?.item = item
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
        dataSource?.didSelectRow = { (indexPath, item) in
            if let model = item?.property?.model {
                //                self.openChildScreen(.CustomerDetailViewController, fromStoryboard: .Home, withContext: RouteContext([RVContext: model]))
            }
        }
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewCustomerHome) {
        
    }
    
    // MARK: - Action Button
    
}

// MARK: - Protocol of Presenter
extension CustomerHomeViewController: CustomerHomeVC {
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
    
    func reloadData() {
        self.dataSource?.stopInfiniteLoading(.FinishLoading)
    }
    
    func resetData() {
        self.items.removeAll()
    }
}


