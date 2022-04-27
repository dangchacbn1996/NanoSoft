//
//  HospitalMainViewController.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 07/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit
import ActionSheetPicker_3_0

class HospitalMainViewController: BaseViewController<CustomerHomePresenter> {
    private let scrollMain = UIScrollView()
    private let stackMain = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .center, spacing: 8)
//    private let vcProduct = ProductTypeViewController()
//    private let vcNews = CustomerNewsViewController()
//    private var vcBooking: CustomerBookingViewController!
//    private let vcService = CustomerServiceViewController()
//    private let vcContact = HospitalContactSiteViewController()
    
    private var tableView: UITableView!
    private var phoneLabel = UILabel(text: "", font: UIFont.customNormal14, color: .white)
//    private var appointmentButton: UIButton!
//    private var callButton: UIButton!
    
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
        setupUI()
        // Do any additional setup after loading the view.
        self.presenter?.initDataPresent()
        self.defaultNavigation()
        
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
        dataSource = TableDataSource<ViewCustomerHome, CellViewCustomerHome, CellDataCustomerHome>.init(.MultipleSection(items: self.items), tableView, true)
        //            dataSource?.refreshProgrammatically()
        
        dataSource?.configureCell = { (cell, item, indexPath) in
            if indexPath.section == 0 {
                (cell as? HomeCustomTableViewCell)?.item = item
                (cell as? HomeCustomTableViewCell)?.moreButton.addAction(for: .touchUpInside, closure: { [weak self](action) in
                    self?.openChildScreen(.CustomerHomeFilterViewController, fromStoryboard: .CustomerHome, withContext: RouteContext([:]))
                })
//                (cell as? HomeCustomTableViewCell)?.selectedData = { [weak self] (selected) in
//                    self?.openChildScreen(.CustomerHomeAppointmentViewController, fromStoryboard: .CustomerHome, withContext: RouteContext([RVContext:selected]))
//                }
                
                (cell as? HomeCustomTableViewCell)?.selectedData = { [weak self] (selected) in
//                    self?.openChildScreen(ExamVipListViewController(), withContext: RouteContext([RVContext:selected]))
                    self?.openChildScreen(HospitalMainViewController(), withContext: RouteContext([RVContext:selected]))
                }
                
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
    
    private func setupUI() {
        self.view.setLinearGradient(startColor: gradientStart, endColor: UIColor.white)
        self.edgesForExtendedLayout = .top
        let vHeader = UIView()
        func setContact() {
            self.view.addSubview(vHeader)
            vHeader.snp.makeConstraints({
                $0.top.centerX.width.equalTo(self.view.safeAreaLayoutGuide)
            })
            let btnHome = UIButton(title: "Trang chủ", font: UIFont.systemFont(ofSize: 24, weight: .bold), titleColor: .white, backColor: .clear, corner: 0)
            vHeader.addSubview(btnHome)
            btnHome.snp.makeConstraints {
                $0.centerY.height.equalToSuperview()
                $0.leading.equalToSuperview().offset(10)
            }
            
            let vContact = UIView()
            vHeader.addSubview(vContact)
            vContact.snp.makeConstraints({
                $0.trailing.equalToSuperview().offset(-10)
                $0.centerY.height.equalToSuperview()
            })
            let icContact = UIImageView(image: UIImage(named: AssetsName.icCall)?.withRenderingMode(.alwaysTemplate))
            vContact.addSubview(icContact)
            icContact.snp.makeConstraints({
                $0.centerY.height.equalToSuperview()
                $0.leading.equalToSuperview()
                $0.width.equalTo(20)
            })
            icContact.tintColor = .white
            icContact.contentMode = .scaleAspectFit
            let lbContact = UILabel(text: "Hotline\n0912345678", font: .systemFont(ofSize: 12, weight: .bold), color: .white, breakable: true)
            vContact.addSubview(lbContact)
            lbContact.snp.makeConstraints({
                $0.centerY.height.trailing.equalToSuperview()
                $0.leading.equalTo(icContact.snp.trailing).offset(8)
            })
        }
        setContact()
        
        tableView = UITableView()
//        self.view.addSubview(tableView)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints({
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(vHeader.snp.bottom)
        })
        self.tableView.backgroundColor = UIColor(hex: "F6FAFC")
        self.tableView.register(HospitalNewsTableViewCell.self, forCellReuseIdentifier: HospitalNewsTableViewCell.id)
        
        tableView.roundCorners([.topLeft, .topRight], radius: 20)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        
    }
    
    // MARK: - Action Button
    
}

// MARK: - Protocol of Presenter
extension HospitalMainViewController: CustomerHomeVC {
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

//class HospitalMainViewController: BaseViewController<HospitalHomeViewModel> {
//
//    private let scrollMain = UIScrollView()
//    private let stackMain = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .center, spacing: 8)
//    private let vcProduct = ProductTypeViewController()
//    private let vcNews = CustomerNewsViewController()
//    private var vcBooking: CustomerBookingViewController!
//    private let vcService = CustomerServiceViewController()
//    private let vcContact = HospitalContactSiteViewController()
//
//    // MARK: - Connect Presenter
//    override func initPresenter(with context: RouteContext?) {
//        presenter = HospitalHomeViewModel()
//        presenter?.attachView(vc: self)
//        presenter?.setContext(to: context)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.presenter?.initDataPresent()
////        defaultNavigation()
//        setupUI()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.isHidden = true
//    }
//
//    func defaultNavigation() {
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.alignment = .fill
//        stackView.distribution = .fill
//
//        let label = UILabel()
//        label.textColor = UIColor.white
//        label.font = .boldSystemFont(ofSize: 17.0.auto())
//        let fullName = UserDefaults.standard.df.fetch(forKey: String(describing: CustomerProfileOptionalResponse.self), type: CustomerProfileOptionalResponse.self)?.hoTen ?? ""
//        label.text = Common.IS_GUEST ? "  Khách hàng" : "  " + fullName
//
//        let images = UIImageView()
//        images.widthAnchor.constraint(equalToConstant: 40.auto()).isActive = true
//        images.heightAnchor.constraint(equalToConstant: 40.auto()).isActive = true
//
//        let urlImage = UserDefaults.standard.df.fetch(forKey: String(describing: CustomerProfileOptionalResponse.self), type: CustomerProfileOptionalResponse.self)?.anhKhachHang ?? ""
//        images.avartaImageView(url: Common.stringToUrlImage(text: urlImage))
//        images.layer.cornerRadius = 20
//        images.clipsToBounds = true
//        images.layer.borderWidth = 1.0
//        images.layer.borderColor = UIColor.white.cgColor
//
//        stackView.addArrangedSubview(images)
//        stackView.addArrangedSubview(label)
//        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
//        stackView.addGestureRecognizer(gesture)
//
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: stackView)
//        self.navigationItem.titleView = nil
//        self.rightMoreButtonNavigation()
//    }
//
//    @objc func checkAction(sender : UITapGestureRecognizer) {
//        // Do what you want
//        if Common.IS_GUEST {
//            self.alertGuest()
//        }
////        else {
////            self.openChildScreen(.CustomerProfileViewController, fromStoryboard: .CustomerHome)
////        }
//    }
//}
//
//extension HospitalMainViewController: HospitalHomeVC {
//    func initData(data: [ViewCustomerHome]) {
//
//    }
//
//    func reloadData() {
//        if let news = presenter?.dataNews {
//            vcNews.reload(listNews: news)
//        }
//        if let contact = presenter?.dataAgency.first {
//            vcContact.bind(contact)
//        }
//        if let filter = presenter?.dataSuggestion {
//            vcBooking.bind(filter)
//        }
//    }
//}
//
//extension HospitalMainViewController {
//    private func setupUI() {
//        self.view.setLinearGradient(startColor: gradientStart, endColor: UIColor.white)
//        self.edgesForExtendedLayout = .top
//        let vHeader = UIView()
//        func setContact() {
//            self.view.addSubview(vHeader)
//            vHeader.snp.makeConstraints({
//                $0.top.centerX.width.equalTo(self.view.safeAreaLayoutGuide)
//            })
//            let btnHome = UIButton(title: "Trang chủ", font: UIFont.systemFont(ofSize: 24, weight: .bold), titleColor: .white, backColor: .clear, corner: 0)
//            vHeader.addSubview(btnHome)
//            btnHome.snp.makeConstraints {
//                $0.centerY.height.equalToSuperview()
//                $0.leading.equalToSuperview().offset(10)
//            }
//
//            let vContact = UIView()
//            vHeader.addSubview(vContact)
//            vContact.snp.makeConstraints({
//                $0.trailing.equalToSuperview().offset(-10)
//                $0.centerY.height.equalToSuperview()
//            })
//            let icContact = UIImageView(image: UIImage(named: AssetsName.icCall)?.withRenderingMode(.alwaysTemplate))
//            vContact.addSubview(icContact)
//            icContact.snp.makeConstraints({
//                $0.centerY.height.equalToSuperview()
//                $0.leading.equalToSuperview()
//                $0.width.equalTo(20)
//            })
//            icContact.tintColor = .white
//            icContact.contentMode = .scaleAspectFit
//            let lbContact = UILabel(text: "Hotline\n0912345678", font: .systemFont(ofSize: 12, weight: .bold), color: .white, breakable: true)
//            vContact.addSubview(lbContact)
//            lbContact.snp.makeConstraints({
//                $0.centerY.height.trailing.equalToSuperview()
//                $0.leading.equalTo(icContact.snp.trailing).offset(8)
//            })
//        }
//        setContact()
//
//        self.view.addSubview(scrollMain)
//        scrollMain.snp.makeConstraints({
//            $0.leading.trailing.bottom.equalToSuperview()
//            $0.top.equalTo(vHeader.snp.bottom)
//        })
//        self.scrollMain.backgroundColor = UIColor(hex: "F6FAFC")
//
//        scrollMain.roundCorners([.topLeft, .topRight], radius: 20)
//        scrollMain.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
//        scrollMain.addSubview(stackMain)
//        stackMain.snp.makeConstraints({
//            $0.edges.equalToSuperview()
//            $0.width.equalTo(self.view)
//        })
////        scrollMain.backgroundColor = .white
//
//        let vSignal = UIView()
//        stackMain.addArrangedSubview(vSignal)
//        vSignal.snp.makeConstraints({
//            $0.width.equalToSuperview()
//        })
////        vSignal.backgroundColor = .white
////        vSignal.roundCorners([.topLeft, .topRight], radius: 20)
//
//        let icLogo = UIImageView(image: UIImage(named: AssetsName.icLogo))
//        vSignal.addSubview(icLogo)
//        icLogo.snp.makeConstraints({
//            $0.centerX.equalToSuperview()
//            $0.top.equalToSuperview().offset(8)
//            $0.size.equalTo(96)
//        })
//        let lbTitle = UILabel(text: "Phòng khám công nghệ 4.0", font: .customOpenSans(18, .bold), color: UIColor(hex: "1A6CEE"))
//        vSignal.addSubview(lbTitle)
//        lbTitle.snp.makeConstraints({
//            $0.top.equalTo(icLogo.snp.bottom).offset(2)
//            $0.centerX.equalToSuperview()
//        })
//
//        let lbSubtitle = UILabel(text: "Niềm tin vào cuộc sống", font: .customOpenSans(16, .semiBoldItalic), color: UIColor(hex: "54C0FF"))
//        vSignal.addSubview(lbSubtitle)
//        lbSubtitle.snp.makeConstraints({
//            $0.top.equalTo(lbTitle.snp.bottom).offset(4)
//            $0.centerX.equalToSuperview()
//            $0.bottom.equalToSuperview()
//        })
//
//        let imAdv = UIImageView(image: UIImage(named: "Bitmap"))
//        stackMain.addArrangedSubview(imAdv)
//        imAdv.snp.makeConstraints({
//            $0.height.equalTo(152)
//            $0.width.equalToSuperview()
//        })
//        imAdv.contentMode = .scaleAspectFill
//        imAdv.clipsToBounds = true
//        let vBooking = UIView()
//        stackMain.addArrangedSubview(vBooking)
//        vBooking.snp.makeConstraints({
//            $0.width.equalToSuperview()
//        })
//        vcBooking = CustomerBookingViewController(context: self.context)
//        self.addChild(vcBooking)
//        vBooking.addSubview(vcBooking.view)
//        vcBooking.view.snp.makeConstraints({
//            $0.edges.equalToSuperview()
//        })
//        vcBooking.didMove(toParent: self)
//
//        let vPro = UIView()
//        stackMain.addArrangedSubview(vPro)
//        vPro.snp.makeConstraints({
//            $0.width.equalToSuperview().offset(-40)
//        })
//        self.addChild(vcProduct)
//        vPro.addSubview(vcProduct.view)
//        vcProduct.view.snp.makeConstraints({
//            $0.edges.equalToSuperview()
//        })
//        vcProduct.didMove(toParent: self)
//
//        let vService = UIView()
//        stackMain.addArrangedSubview(vService)
//        vService.snp.makeConstraints({
//            $0.width.equalToSuperview().offset(-40)
//        })
//        self.addChild(vcService)
//        vService.addSubview(vcService.view)
//        vcService.view.snp.makeConstraints({
//            $0.edges.equalToSuperview()
//        })
//        vcService.didMove(toParent: self)
//
//        let vNews = UIView()
//        stackMain.addArrangedSubview(vNews)
//        vNews.snp.makeConstraints({
//            $0.width.equalToSuperview().offset(-40)
//        })
//        self.addChild(vcNews)
//        vNews.addSubview(vcNews.view)
//        vcNews.view.snp.makeConstraints({
//            $0.edges.equalToSuperview()
//        })
//        vcNews.didMove(toParent: self)
//
//        let vContact = UIView()
//        stackMain.addArrangedSubview(vContact)
//        vContact.snp.makeConstraints({
//            $0.width.equalToSuperview().offset(-40)
//        })
//        self.addChild(vcContact)
//        vContact.addSubview(vcContact.view)
//        vcContact.view.snp.makeConstraints({
//            $0.edges.equalToSuperview()
//        })
//        vcContact.didMove(toParent: self)
////        vContact.addSubView(UIView()) { (textContainer) in
////            textContainer.snp.makeConstraints({
////                $0.top.equalTo(vContact.subviews[0].snp.bottom).offset(10)
////                $0.centerX.width.equalToSuperview()
////                $0.bottom.equalToSuperview()
////            })
////            textContainer.layer.cornerRadius = 10
////            textContainer.layer.borderColor = AppColors.textBlue.cgColor
////            textContainer.layer.borderWidth = 1
////
////            textContainer.addSubView(UILabel(font: UIFont.customOpenSans(12, .regular), color: AppColors.textBlue, breakable: true)) { (view) in
////                if let label = view as? UILabel {
////                    label.snp.makeConstraints({
////                        $0.center.equalToSuperview()
////                        $0.size.equalToSuperview().offset(-16)
////                    })
////
////                    label.text = "Lô số 207 & 208, Khu dân tư Tây Nam chợ Quảng Thắng, P.Quảng Thắng, TP. Thanh Hoá, Thanh Hoá, Việt Nam\nĐiện thoại: 098.345.4040\ntrungtamykhoahanoi@gmail.com"
////                }
////            }
////        }
//    }
//}
//
class CustomerBookingViewController: UITableViewCell {
    
    static let id = "CustomerBookingViewController"

    private let lbSpecialist = UILabel(font: .customOpenSans(14, .semiBold), color: UIColor(hex: "3B3A43"), breakable: true)
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var listData: [SuggestionCustomerHomeOptionalResponse] = []
    private let lbChooseMajor = UILabel(text: "Chọn khoa", font: .customOpenSans(14, .bold), color: UIColor(hex: "616066"))
    private var vChooseMajor = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateModel(model: NewCustomerHomeOptionalResponse) {
//        self.categoryTitleLabel.text = model.tenNhomNews
//        self.dateLabel.text = model.ngayCapNhat
//        self.avartaImageview.pictureSquareImageView(url: Common.stringToUrlImage(text: model.anhDaiDien ?? ""))
//        self.descLabel.text = model.tieuDe
    }
//
//    convenience init(context: RouteContext?) {
//        self.init()
//        self.context = context
//    }
//
//    init() {
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        presenter?.initDataPresent()
//        presenter?.attachView(vc: self)
//        presenter?.detachView()
    func setupUI() {
        let icBooking = UIImageView(image: UIImage(named: AssetsName.icHeaderBooking))
        self.addSubview(icBooking)
        icBooking.snp.makeConstraints({
            $0.height.equalTo(24)
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(10)
        })
        icBooking.contentMode = .scaleAspectFit

        let lbTitle = UILabel(text: "Đặt lịch hẹn", font: .customOpenSans(20, .bold), color: UIColor(hex: "EE1A1A"))
        self.addSubview(lbTitle)
        lbTitle.snp.makeConstraints({
            $0.leading.equalTo(icBooking.snp.trailing).offset(8)
            $0.centerY.equalTo(icBooking)
        })

        func selectRow(icon: UIImage?, label: UILabel) -> (UIView) {
            let selectView = UIView(backColor: .clear, corner: 14, border: 1, borderColor: UIColor(hex: "1A6CEE"))
            selectView.snp.makeConstraints({
                $0.height.equalTo(36)
            })
            selectView.addSubview(label)
            label.snp.makeConstraints({
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().offset(16)
            })

            let icDropdown = UIImageView(image: UIImage(named: AssetsName.icDropdown)?.withRenderingMode(.alwaysTemplate))
            icDropdown.tintColor = UIColor(hex: "1A6CEE")
            selectView.addSubview(icDropdown)
            icDropdown.snp.makeConstraints({
                $0.centerY.equalToSuperview()
                $0.height.equalToSuperview().multipliedBy(0.8)
                $0.trailing.equalToSuperview().offset(-16)
                $0.width.equalTo(16)
                $0.leading.equalTo(label.snp.trailing).offset(8)
            })
            icDropdown.contentMode = .scaleAspectFit
            return selectView
        }

        vChooseMajor = selectRow(icon: nil, label: lbChooseMajor)
        vChooseMajor.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.actShowMajor)))
        self.addSubview(vChooseMajor)
        vChooseMajor.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().offset(-20)
            $0.top.equalTo(icBooking.snp.bottom).offset(8)
        })

//        let lbChooseDoctor = UILabel(text: "Tìm bác sĩ", font: .customOpenSans(14, .regular), color: UIColor(hex: "EE1A1A"))
//        let vChooseDoctor = selectRow(icon: nil, label: lbChooseDoctor)
//        self.view.addSubview(vChooseDoctor)
//        vChooseDoctor.snp.makeConstraints({
//            $0.centerX.size.equalTo(vChooseMajor)
//            $0.top.equalTo(vChooseMajor.snp.bottom).offset(8)
//        })


//        let lbChooseDoctor = UILabel(text: "Chọn bác sĩ chuyên khoa:", font: UIFont.customOpenSans(16, .semiBold), color: AppColors.textBlack)
//        self.view.addSubview(lbChooseDoctor)
//        lbChooseDoctor.snp.makeConstraints({
//            $0.centerX.width.equalTo(vChooseType)
//            $0.top.equalTo(vChooseType.snp.bottom).offset(8)
//        })

        let lbDes = UILabel(text: "Chọn bác sĩ chuyên khoa:", font: UIFont.customOpenSans(16, .semiBold), color: AppColors.textBlack)
        self.addSubview(lbDes)
        lbDes.snp.makeConstraints({
            $0.leading.equalToSuperview().offset(10)
            $0.top.equalTo(vChooseMajor.snp.bottom).offset(8)
        })

        self.addSubview(collectionView)
        collectionView.snp.makeConstraints({
            $0.top.equalTo(lbDes.snp.bottom).offset(8)
            $0.height.equalTo(132)
            $0.leading.trailing.equalToSuperview()
        })
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
        collectionView.backgroundColor = .clear
//        collectionView.register(CustomerBookingDoctorCVC.self, forCellWithReuseIdentifier: CustomerBookingDoctorCVC.id)
//        collectionView.delegate = self
//        collectionView.dataSource = self

        let btnBook = UIButton(title: "Đặt hẹn", font: UIFont.customOpenSans(20, .bold), titleColor: UIColor.white, backColor: UIColor(hex: "EE1A1A"), corner: 8)
        self.addSubview(btnBook)
        btnBook.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-16)
            $0.height.equalTo(50)
            $0.width.equalTo(200)
            $0.top.equalTo(collectionView.snp.bottom).offset(8)
        })
    }

    func bind(_ data: [SuggestionCustomerHomeOptionalResponse]) {
        self.listData = data
    }

    @objc private func actShowMajor() {
//        let list = self.listData.map{ "\($0.tenDichVu ?? "")"}
//        ActionSheetStringPicker(title: "Chọn khoa", rows: list, initialSelection: 0, doneBlock: { (picker, index, value) in
//            self.lbChooseMajor.text = (value as? String) ?? ""
//            if let id = self.listData[index].idNhomDichVu {
//                self.presenter?.setIdNhom(index: id)
//            }
//        }, cancel: nil, origin: self.vChooseMajor).show()
    }
}

//extension CustomerBookingViewController: HospitalBookingDoctorVC {
//    func initData(data: [ViewCustomerHome]) {
//
//    }
//
//    func reloadData() {
//        self.collectionView.reloadData()
//    }
//}

//extension CustomerBookingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomerBookingDoctorCVC.id, for: indexPath)
//        if let data = presenter?.doctorsData[indexPath.item] {
//            (cell as? CustomerBookingDoctorCVC)?.bind(data)
//        }
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return presenter?.doctorsData.count ?? 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: (self.view.bounds.width - 50) / 4.5, height: collectionView.bounds.height)
//    }
//}



//class CustomerBookingDoctorCVC: UICollectionViewCell {
//    static let id = "CustomerBookingDoctorCVC"
//
//    private let imAvatar = UIImageView(image: UIImage(named: AssetsName.defaultAvatar))
//    private let lbName = UILabel(text: "J.Robert", font: .customOpenSans(12, .semiBold), color: UIColor(hex: "1A6CEE"))
//    private let lbIntro = UILabel(text: "Chưởng khoa nhi viện Nhi TW", font: .customOpenSans(9, .regular), color: AppColors.textBlack, breakable: true)
//    private var data: ModelOptionResponseEmployeeAndSearchCatalogDatum? = nil
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func bind(_ data: ModelOptionResponseEmployeeAndSearchCatalogDatum) {
//        self.imAvatar.pictureSquareImageView(url: Common.stringToUrlImage(text: data.anhNhanVien ?? ""))
//        self.lbName.text = data.tenNhanVien
//        self.lbIntro.text = data.moTa
//    }
//
//    private func setupUI() {
//        let vContainer = UIView()
//        self.addSubview(vContainer)
//        vContainer.layer.cornerRadius = 4
//        vContainer.snp.makeConstraints({
//            $0.top.leading.equalToSuperview().offset(4)
//            $0.bottom.trailing.equalToSuperview().offset(-4)
//        })
////        vContainer.dropShadow()
//        vContainer.addSubview(imAvatar)
//        imAvatar.snp.makeConstraints({
//            $0.top.leading.trailing.equalToSuperview()
////            $0.height.equalTo(imAvatar.snp.width).offset(1.2)
//        })
//        imAvatar.clipsToBounds = true
//        imAvatar.contentMode = .scaleAspectFill
//        vContainer.addSubview(lbName)
//        lbName.snp.makeConstraints({
//            $0.height.equalTo(12)
//            $0.centerX.equalToSuperview()
//            $0.width.equalToSuperview().offset(-8)
//            $0.top.equalTo(imAvatar.snp.bottom).offset(4)
//        })
//        lbName.textAlignment = .center
//        vContainer.addSubview(lbIntro)
//        lbIntro.snp.makeConstraints({
//            $0.top.equalTo(lbName.snp.bottom).offset(4)
//            $0.centerX.equalToSuperview()
//            $0.height.equalTo(24)
//            $0.width.equalToSuperview().offset(-8)
//            $0.bottom.equalToSuperview().offset(-4)
//        })
//    }
//}
//
//class ProductTypeViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        func vProduct(icon: UIImage?, title: String, backColor: UIColor) -> UIView {
//            let v = UIView()
//            v.layer.cornerRadius = 8
//            v.backgroundColor = backColor
//            let image = UIImageView(image: icon)
//            v.addSubview(image)
//            image.snp.makeConstraints({
//                $0.centerX.equalToSuperview()
//                $0.top.equalToSuperview().offset(8)
//                $0.height.equalTo(32)
//            })
//            image.contentMode = .scaleAspectFit
//
//            let lbTitle = UILabel(text: title, font: UIFont.customOpenSans(12, .bold), color: AppColors.textBlack, breakable: true)
//            v.addSubview(lbTitle)
//            lbTitle.snp.makeConstraints({
//                $0.top.equalTo(image.snp.bottom)
//                $0.centerX.equalToSuperview()
//                $0.width.equalToSuperview().offset(-8)
//                $0.bottom.equalToSuperview().offset(-8)
//            })
//            lbTitle.textAlignment = .center
//            v.snp.makeConstraints({
//                $0.width.equalTo(v.snp.height)
//            })
//            return v
//        }
//        let view1 = vProduct(icon: UIImage(named: "ic_kit"), title: "Khám và xét nghiệm", backColor: UIColor(hex: "FFD65C"))
//        let view2 = vProduct(icon: UIImage(named: "ic_bed"), title: "Khám bệnh tại nhà", backColor: UIColor(hex: "C0CB45"))
//        let view3 = vProduct(icon: UIImage(named: "ic_docs"), title: "Tra cứu bệnh án", backColor: UIColor(hex: "FFA83D"))
//        let view4 = vProduct(icon: UIImage(named: "ic_company"), title: "Khám doanh nghiệp", backColor: UIColor(hex: "FFA83D"))
//        let view5 = vProduct(icon: UIImage(named: "ic_ambulance"), title: "Khám TTS VIP", backColor: UIColor(hex: "C0CB45"))
//        let view6 = vProduct(icon: UIImage(named: "ic_contact"), title: "Hỏi đáp với bác sĩ", backColor: UIColor(hex: "FFD65C"))
//
//        let stack1 = UIStackView(axis: .horizontal, distribution: .fillEqually, alignment: .fill, spacing: 20)
//        self.view.addSubview(stack1)
//        stack1.snp.makeConstraints({
//            $0.top.centerX.equalToSuperview()
//            $0.width.equalToSuperview()
//        })
//        stack1.addArrangedSubview(view1)
//        stack1.addArrangedSubview(view2)
//        stack1.addArrangedSubview(view3)
//
//        let stack2 = UIStackView(axis: .horizontal, distribution: .fillEqually, alignment: .fill, spacing: 20)
//        self.view.addSubview(stack2)
//        stack2.snp.makeConstraints({
//            $0.bottom.centerX.equalToSuperview()
//            $0.top.equalTo(stack1.snp.bottom).offset(20)
//            $0.width.equalToSuperview()
//        })
//        stack2.addArrangedSubview(view4)
//        stack2.addArrangedSubview(view5)
//        stack2.addArrangedSubview(view6)
//
////        stack1.arrangedSubviews.forEach({$0.dropShadow()})
////        stack2.arrangedSubviews.forEach({$0.dropShadow()})
//    }
//}
//
//fileprivate class CustomerServiceViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//    }
//
//    @objc func actSelect() {
//        let vc = HospitalVIPListServiceViewController()
//        self.parent?.navigationController?.pushViewController(vc, animated: true)
//
//    }
//
//    private func setupUI() {
//        let lbTitle = UILabel(text: "Dịch vụ", font: .customOpenSans(14, .bold), color: AppColors.textBlack)
//        self.view.addSubview(lbTitle)
//        lbTitle.snp.makeConstraints({
//            $0.leading.equalToSuperview()
//            $0.top.equalToSuperview().offset(8)
//        })
//
//        let lbDescription = UILabel(text: "Gói khám sức khoẻ", font: UIFont.customOpenSans(12, .semiBold), color: AppColors.textBlue)
//        self.view.addSubview(lbDescription)
//        lbDescription.snp.makeConstraints({
//            $0.leading.equalToSuperview()
//            $0.top.equalTo(lbTitle.snp.bottom).offset(12)
//        })
//
//        let vService = UIView()
//        self.view.addSubview(vService)
//        vService.snp.makeConstraints({
//            $0.centerX.width.equalToSuperview()
//            $0.bottom.equalToSuperview()
//            $0.height.equalTo(vService.snp.width).multipliedBy(0.5)
//            $0.top.equalTo(lbDescription.snp.bottom).offset(8)
//        })
//        vService.layer.cornerRadius = 10
//        vService.clipsToBounds = true
//        let imageService = UIImageView(image: UIImage(named: "im_service"))
//        vService.addSubview(imageService)
//        imageService.snp.makeConstraints({
//            $0.edges.equalToSuperview()
//        })
//        imageService.clipsToBounds = true
//        imageService.contentMode = .scaleAspectFill
//
//        func vProduct(title: String) -> UIView {
//            let v = UIView()
//            v.layer.cornerRadius = 8
//
//            let lbTitle = UILabel(text: title, font: UIFont.customOpenSans(12, .regular), color: UIColor(hex: "F57E28"), breakable: true)
//            v.addSubview(lbTitle)
//            v.backgroundColor = UIColor.white
//            v.layer.cornerRadius = 8
//            v.clipsToBounds = true
//            lbTitle.snp.makeConstraints({
//                $0.center.equalToSuperview()
//                $0.size.equalToSuperview().offset(-8)
//            })
//            lbTitle.textAlignment = .center
////            v.isUser = true
//            v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.actSelect)))
//            return v
//        }
//        let view1 = vProduct(title: "Gói khám cơ bản")
//        let view2 = vProduct(title: "Gói khám toàn diện")
//        let view3 = vProduct(title: "Gói khám VIP")
//        let view4 = vProduct(title: "Gói khám tổng quát")
//        let view5 = vProduct(title: "Gói khám chuyên gia")
//        let view6 = vProduct(title: "Gói khám ưu tiên")
//
//        let stack1 = UIStackView(axis: .vertical, distribution: .fillEqually, alignment: .fill, spacing: 10)
//        vService.addSubview(stack1)
//        stack1.snp.makeConstraints({
//            $0.centerY.equalToSuperview()
//            $0.width.equalToSuperview().multipliedBy(0.22)
//            $0.height.equalToSuperview().offset(-20)
//            $0.leading.equalToSuperview().offset(10)
//        })
//        stack1.addArrangedSubview(view1)
//        stack1.addArrangedSubview(view2)
//        stack1.addArrangedSubview(view3)
//
//        let stack2 = UIStackView(axis: .vertical, distribution: .fillEqually, alignment: .fill, spacing: 10)
//        vService.addSubview(stack2)
//        stack2.snp.makeConstraints({
//            $0.centerY.size.equalTo(stack1)
//            $0.leading.equalTo(stack1.snp.trailing).offset(10)
//        })
//        stack2.addArrangedSubview(view4)
//        stack2.addArrangedSubview(view5)
//        stack2.addArrangedSubview(view6)
//
////        stack1.arrangedSubviews.forEach({$0.dropShadow()})
////        stack2.arrangedSubviews.forEach({$0.dropShadow()})
//    }
//}

//class CustomerNewsViewController: UITableViewCell {
//
//    private let lbSpecialist = UILabel(font: .customOpenSans(14, .semiBold), color: UIColor(hex: "3B3A43"), breakable: true)
//    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
//    private var data: [NewCustomerHomeOptionalResponse] = [] {
//        didSet {
//            collectionView.reloadData()
//        }
//    }
//
//    var item: DefaultCellModel<CustomerSocialOptionalResponse>? {
//        didSet {
////            let model = item?.property?.model
//
////            self.dateQuestionLabel.text = model?.ngayTao
////            self.titleQuestionLabel.text = model?.noiDungCauHoi
////
////            if model?.cauTraLoi?.count ?? 0 > 0 {
////                self.cardViewOverlay.isHidden = false
////                self.viewQuestion.resetCard()
////                self.titleAnswerLabel.text = model?.cauTraLoi?.first?.bacSyTuVan
////                self.dateAnswerLabel.text = model?.cauTraLoi?.first?.ngayTao
////                self.descAnswerLabel.text = model?.cauTraLoi?.first?.noiDungTraLoi
////                let heightLabel: CGFloat = heightForView(text: model?.cauTraLoi?.first?.noiDungTraLoi ?? "", font: UIFont.boldSystemFont(ofSize: 20.0), width: self.viewAnswer.frame.width)
////                self.heightConstraint.constant = 117.0 + heightLabel
////                self.viewAnswer.isHidden = false
////            } else {
////                self.viewQuestion.usingShadow()
////                self.cardViewOverlay.isHidden = true
////                self.viewAnswer.isHidden = true
////                self.heightConstraint.constant = 0
////            }
//        }
//    }
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.setupUI()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func setupUI() {
////    override func viewDidLoad() {
////        super.viewDidLoad()
//
//        let lbTitle = UILabel(text: "Tin tức", font: .customOpenSans(20, .bold), color: AppColors.textBlack)
//        self.addSubview(lbTitle)
//        lbTitle.snp.makeConstraints({
//            $0.leading.equalToSuperview()
//            $0.top.equalToSuperview().offset(8)
//        })
//
//        let btnMore = UIButton(title: "(Xem thêm)", font: .customOpenSans(14, .bold), titleColor: AppColors.textBlue, backColor: .clear, corner: 0)
//        self.addSubview(btnMore)
//        btnMore.snp.makeConstraints({
//            $0.trailing.equalToSuperview()
//            $0.centerY.equalTo(lbTitle)
//        })
//
//        self.addSubview(collectionView)
//        collectionView.snp.makeConstraints({
//            $0.top.equalTo(lbTitle.snp.bottom).offset(8)
//            $0.height.equalTo(250)
//            $0.bottom.equalToSuperview()
//            $0.leading.trailing.equalToSuperview()
//        })
////        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//        collectionView.bounces = false
//        collectionView.showsHorizontalScrollIndicator = false
//        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
//        collectionView.backgroundColor = .clear
//        collectionView.register(CustomerNewsCVC.self, forCellWithReuseIdentifier: CustomerNewsCVC.id)
//        collectionView.delegate = self
//        collectionView.dataSource = self
//    }
//
//    func reload(listNews: [NewCustomerHomeOptionalResponse]) {
//        self.data = listNews
//    }
//}
//
//extension CustomerNewsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomerNewsCVC.id, for: indexPath)
//        (cell as? CustomerNewsCVC)?.bind(self.data[indexPath.item])
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return data.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: (self.bounds.width - 50) / 1.2, height: collectionView.bounds.height / 2 - 5)
//    }
//
////    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
////        Router(viewController: self)
////            .openScreen(Screen.CustomerHomeNewsViewController, fromStoryboard: Storyboard.CustomerHome, isChildScreen: true, withContext: RouteContext([RVContext:data[indexPath.item]]))
////    }
//}
//
//class CustomerNewsCVC: UICollectionViewCell {
//    static let id = "CustomerNewsCVC"
//
//    private let imAvatar = UIImageView(image: UIImage(named: AssetsName.defaultAvatar))
//    private let lbTitle = UILabel(text: "Phòng khám công nghệ 4.0 chuẩn quốc tế", font: .customOpenSans(14, .regular), color: AppColors.textBlack, breakable: true)
//    private let lbContent = UILabel(text: "Phục lục Tài liệu thống nhất Mokup chức năng, giao diện App", font: .customOpenSans(12, .regular), color: AppColors.textBlack, breakable: true)
//    private let lbUpdatetime = UILabel(text: "1h trước", font: .customOpenSans(12, .regular), color: UIColor(hex: "616066"), breakable: true)
//    private var data: NewCustomerHomeOptionalResponse? = nil
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func bind(_ data: NewCustomerHomeOptionalResponse) {
//        self.data = data
//        imAvatar.pictureSquareImageView(url: Common.stringToUrlImage(text: data.anhDaiDien ?? ""))
//        lbTitle.text = data.tieuDe
//        lbContent.text = data.moTa
//    }
//
//    private func setupUI() {
//        let vContainer = UIView()
//        self.addSubview(vContainer)
//        vContainer.layer.cornerRadius = 4
//        vContainer.snp.makeConstraints({
//            $0.top.leading.equalToSuperview().offset(4)
//            $0.bottom.trailing.equalToSuperview().offset(-4)
//        })
//        vContainer.backgroundColor = .white
//        vContainer.layer.cornerRadius = 10
//        vContainer.clipsToBounds = true
////        vContainer.layer.borderWidth = 1
////        vContainer.layer.borderColor = AppColors.textBlue.cgColor
////        vContainer.clipsToBounds = true
//        vContainer.addSubview(imAvatar)
//        imAvatar.snp.makeConstraints({
//            $0.centerY.leading.height.equalToSuperview()
//            $0.width.equalToSuperview().multipliedBy(0.34)
//        })
//        imAvatar.clipsToBounds = true
//        imAvatar.contentMode = .scaleAspectFill
//        imAvatar.layer.cornerRadius = 10
//
//        vContainer.addSubview(lbTitle)
//        lbTitle.snp.makeConstraints({
//            $0.leading.equalTo(imAvatar.snp.trailing).offset(4)
//            $0.top.equalToSuperview().offset(4)
//            $0.trailing.equalToSuperview().offset(-4)
//        })
//        lbTitle.numberOfLines = 2
//        lbTitle.textAlignment = .center
//
//        vContainer.addSubview(lbContent)
//        lbContent.snp.makeConstraints({
//            $0.centerX.width.equalTo(lbTitle)
//            $0.top.equalTo(lbTitle.snp.bottom).offset(4)
//        })
//
//        lbContent.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)
//
//        vContainer.addSubview(lbUpdatetime)
//        lbUpdatetime.snp.makeConstraints({
//            $0.bottom.trailing.equalToSuperview().offset(-4)
//            $0.top.equalTo(lbContent.snp.bottom).offset(4)
//        })
//        lbContent.setContentHuggingPriority(UILayoutPriority(250), for: .vertical)
//    }
//}

//class HospitalContactSiteViewController: UITableViewCell {
//    private let lbTitle = UILabel(text: "Thông tin liên hệ", font: .customOpenSans(16, .bold), color: AppColors.textRed)
//
//    private let lbAddress = UILabel(text: "", font: .customOpenSans(14, .semiBold), color: AppColors.textBlack, breakable: true)
//    private let lbTime = UILabel(text: "", font: .customOpenSans(14, .semiBold), color: AppColors.textBlack, breakable: true)
//    private let lbEmail = UILabel(text: "", font: .customOpenSans(14, .semiBold), color: UIColor(hex: "3FADFC"), breakable: true)
//    private let lbPhone = UILabel(text: "", font: .customOpenSans(14, .semiBold), color: UIColor(hex: "3FADFC"), breakable: true)
//    private let lbWebsite = UILabel(text: "", font: .customOpenSans(14, .semiBold), color: UIColor(hex: "3FADFC"), breakable: true)
//
//    var data: AgencyCustomerHomeOptionalResponse? = nil
//
//    override func viewDidLoad() {
//        self.view.addSubview(lbTitle)
//        lbTitle.snp.makeConstraints({
//            $0.leading.top.equalToSuperview()
//        })
//
//        let vContainer = CardView()
//        self.view.addSubview(vContainer)
//        vContainer.snp.makeConstraints({
//            $0.top.equalTo(lbTitle.snp.bottom).offset(8)
//            $0.centerX.width.bottom.equalToSuperview()
//        })
//        vContainer.backgroundColor = .white
//
//        func infoLine(icon: UIImage?, label: UILabel) -> (UIView) {
//            let v = UIView()
//            let image = UIImageView(image: icon?.withRenderingMode(.alwaysTemplate))
//            v.addSubview(image)
//            image.snp.makeConstraints({
//                $0.top.leading.equalToSuperview()
//                $0.size.equalTo(16)
//                $0.height.lessThanOrEqualToSuperview()
//            })
//            image.tintColor = AppColors.textBlack
//            v.addSubview(label)
//            label.snp.makeConstraints({
//                $0.top.equalToSuperview().offset(4)
//                $0.trailing.bottom.equalToSuperview()
//                $0.leading.equalTo(image.snp.trailing).offset(8)
//            })
//            return v
//        }
//        let stackMain = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .fill, spacing: 4)
//        vContainer.addSubview(stackMain)
//        stackMain.snp.makeConstraints({
//            $0.center.equalToSuperview()
//            $0.size.equalToSuperview().offset(-12)
//        })
//        stackMain.addArrangedSubview(infoLine(icon: UIImage(named: "ic_address"), label: lbAddress))
////        stackMain.addArrangedSubview(infoLine(icon: UIImage(named: ""), label: lbTime))
//        stackMain.addArrangedSubview(infoLine(icon: UIImage(named: "ic_email"), label: lbEmail))
//        stackMain.addArrangedSubview(infoLine(icon: UIImage(named: "ic_call"), label: lbPhone))
//        stackMain.addArrangedSubview(infoLine(icon: UIImage(named: "ic_website"), label: lbWebsite))
//    }
//
//    func bind(_ data: AgencyCustomerHomeOptionalResponse) {
//        lbAddress.text = data.diaChi
//        lbTime.text = data.fax
//        lbEmail.text = data.email
//        lbPhone.text = data.hotline
//        lbWebsite.text = data.website
//    }
//}
