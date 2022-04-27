//
//  CustomerSocialViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/22/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit
import JXSegmentedView
import M13Checkbox

class CustomerSocialViewController: BaseViewController<CustomerSocialPresenter> {
    // MARK: - IBOutlet
    
    enum CheckType {
        case all
        case personal
    }
    
    @IBOutlet weak var backgroundViewColor: UIView!
    @IBOutlet weak var titleNavigation: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searhView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var vCheckAll: UIView!
    @IBOutlet weak var vCheckPersonal: UIView!
    private var checkAll: M13Checkbox!
    private var checkPersonal: M13Checkbox!
    private var checkType: CheckType = .all {
        didSet {
            if checkType == .all {
                checkAll.setCheckState(.checked, animated: true)
                checkPersonal.setCheckState(.unchecked, animated: true)
            } else {
                checkAll.setCheckState(.unchecked, animated: true)
                checkPersonal.setCheckState(.checked, animated: true)
            }
            self.presenter?.requestData.isPublic = checkType == .all ? 0 : 1
            self.presenter?.requestData.pageNum = 1
            self.presenter?.socialQuestionService()
        }
    }
    
    @IBAction func searchButton(_ sender: Any) {
        self.searhView.isHidden = false
        self.searchButton.isHidden = true
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.backgroundColor = .white
            searchBar.searchTextField.tintColor = .black
            searchBar.searchTextField.becomeFirstResponder()
        } else {
            // Fallback on earlier versions
            for view : UIView in (searchBar.subviews[0]).subviews {
                if let textField = view as? UITextField {
                    textField.backgroundColor = .clear
                    textField.tintColor = .black
                    textField.becomeFirstResponder()
                }
            }
        }
    }
    var segmentedDataSource: JXSegmentedTitleImageDataSource!
    var listContainerView: JXSegmentedListContainerView!
    var searchText: String = ""
    @IBOutlet weak var listSocial: JXSegmentedView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
//    @IBOutlet weak var logoutButton: UIButton!
    var dataBack: Bool?
    
    var items: [CustomerSocialOptionalResponse] = []
    private var dataSource: TableDataSource<DefaultHeaderFooterModel<CustomerSocialOptionalResponse>,
                                            DefaultCellModel<CustomerSocialOptionalResponse>,
                                            CustomerSocialOptionalResponse>?
    
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = CustomerSocialPresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    @IBAction
    private func actCheckAll() {
        if checkType != .all {
            checkType = .all
        }
    }
    
    @IBAction
    private func actCheckPersonal() {
        if checkType != .personal {
            checkType = .personal
        }
    }
    
    func getTitles() -> [String] {
        var resultTitles = Common.socialCatalog.map({$0.tenNhomChuDe ?? ""})
        resultTitles.insert("Tất cả", at: 0)
        return resultTitles
    }
    
    func getImageTitle() -> [String] {
        let resultTitles = self.getTitles()
        var titleImages : [String] = []
        for (index,_) in resultTitles.enumerated() {
            if index == 0 {
                titleImages.append("black")
            } else {
                titleImages.append("ic-flower")
            }
        }
        return titleImages
    }
    
    func getImageSelectedTitle() -> [String] {
        let resultTitles = self.getTitles()
        var titleImages : [String] = []
        for (index,_) in resultTitles.enumerated() {
            if index == 0 {
                titleImages.append("ic-menu-first")
            } else {
                titleImages.append("ic_flower2")
            }
        }
        return titleImages
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.presenter?.initDataPresent()
        self.configureTableView()
        
        checkAll = M13Checkbox()
        checkAll.markType = .radio
        checkAll.boxType = .circle
        checkAll.stateChangeAnimation = .fill
        vCheckAll.addSubview(checkAll)
        checkAll.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.size.equalToSuperview().multipliedBy(0.5)
        })
        checkAll.isUserInteractionEnabled = false
        
        checkPersonal = M13Checkbox()
        checkPersonal.markType = .radio
        checkPersonal.boxType = .circle
        checkPersonal.stateChangeAnimation = .fill
        vCheckPersonal.addSubview(checkPersonal)
        checkPersonal.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.size.equalTo(checkAll)
        })
        checkPersonal.isUserInteractionEnabled = false
        
        checkAll.setCheckState(.checked, animated: false)
        checkPersonal.setCheckState(.unchecked, animated: false)
        
        searchBar.showsCancelButton = true
//        searchBar.setImage(UIImage(), for: .search, state: .normal)
        searchBar.delegate = self
        
        
        segmentedDataSource = JXSegmentedTitleImageDataSource()
        segmentedDataSource.titles = self.getTitles()
        segmentedDataSource.titleNormalColor = .white
        segmentedDataSource.titleSelectedStrokeWidth = 10
        segmentedDataSource.titleSelectedColor = AppColors.primaryColor
//        segmentedDataSource.titleSelectedColor = UIColor.red
        segmentedDataSource.isTitleColorGradientEnabled = true
        segmentedDataSource.titleImageType = . leftImage
        segmentedDataSource.isImageZoomEnabled = true
        segmentedDataSource.normalImageInfos = self.getImageTitle()
        segmentedDataSource.loadImageClosure = {(imageView, normalImageInfo) in
            imageView.image = UIImage(named: normalImageInfo)
        }
        segmentedDataSource.selectedImageInfos = self.getImageSelectedTitle()
        
//        func setNextButton() {
//            let gradient = CAGradientLayer()
//            let bounds = self.nextButton.bounds
//            gradient.frame = bounds
//            gradient.colors = [gradientStart.cgColor, gradientMid.cgColor]
//            gradient.startPoint = CGPoint(x: 0, y: 0)
//            gradient.endPoint = CGPoint(x: 1, y: 1)
//            if let image = getImageFrom(gradientLayer: gradient) {
//                self.nextButton.layer.cornerRadius =
//                self.nextButton.setImage(image, for: .normal)
//            }
//        }
//        setNextButton()
        
        let gradient = CAGradientLayer()
        let bounds = self.view.bounds
        gradient.frame = bounds
        gradient.colors = [AppColors.gradientStart.cgColor, AppColors.gradientMid.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        
        if let image = getImageFrom(gradientLayer: gradient) {
            self.listSocial.removeShadow()
            self.listSocial.backgroundColor = UIColor.clear
            self.backgroundViewColor.backgroundColor = UIColor(patternImage: image)
        }
        
        listSocial.dataSource = segmentedDataSource
        
        let indicator = JXSegmentedIndicatorBackgroundView()
        indicator.indicatorHeight = 35
        indicator.indicatorCornerRadius = 4
        
        indicator.indicatorWidthIncrement = 15
        indicator.indicatorColor = UIColor.white
        listSocial.indicators = [indicator]
        
        listSocial.delegate = self
        
        listSocial.listContainer = listContainerView
        
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        
        self.titleNavigation.text = "TabBar.Social".localized
    }
    
    override func viewWillAppear(_ animated: Bool) { // As soon as vc appears
        super.viewWillAppear(true)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) { // As soon as vc disappears
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func updatePanData(context: RouteContext) {
        super.updatePanData(context: context)
        self.dataBack = context[RVBackContext]
        if let isReload = self.dataBack {
            if isReload == true {
                self.presenter?.originCustomerService()
            }
        }
        
        
    }
    
    // MARK: - TableView Setup
    private func configureTableView() {
        dataSource = TableDataSource<DefaultHeaderFooterModel<CustomerSocialOptionalResponse>, DefaultCellModel<CustomerSocialOptionalResponse>, CustomerSocialOptionalResponse>.init(.SingleListing(items: items, identifier: CustomerHomeTableViewCell.identfier, height: UITableView.automaticDimension, leadingSwipe: nil, trailingSwipe: nil), tableView)
        //            dataSource?.refreshProgrammatically()
        
        dataSource?.configureCell = { (cell, item, indexPath) in
            (cell as? CustomerHomeTableViewCell)?.item = item
        }
        
        dataSource?.addPullToRefresh = { [weak self] in
            self?.resetData()
            self?.presenter?.socialQuestionService()
        }
        
        dataSource?.addInfiniteScrolling = { [weak self] (page) in
            //            self?.presenter?.requestData.keyWord = self?.searchText ?? ""
            self?.presenter?.requestData.pageNum = page
            self?.presenter?.socialQuestionService()
        }
        dataSource?.didSelectRow = { (indexPath, item) in
            if let model = item?.property?.model {
                self.openChildScreen(.CustomerSocialDetailViewController, fromStoryboard: .CustomerHome, withContext: RouteContext([RVContext: model]))
            }
        }
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //        self.navigationController?.navigationBar.isHidden = false
    //    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewCustomerSocial) {
        
    }
    
    // MARK: - Action Button
    @IBAction func nextButtonAction(_ sender: Any) {
        if Common.IS_GUEST {
            self.alertGuest()
        } else {
            self.openChildScreen(.CreateCustomerSocialViewController, fromStoryboard: .CustomerHome)
        }
    }
    
}

// MARK: - Protocol of Presenter
extension CustomerSocialViewController: CustomerSocialVC {
    func initData(data: [CustomerSocialOptionalResponse]) {
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
    
    func resetTableView() {
        self.items = []
        self.dataSource?.updateAndReload(for: .SingleListing(items: self.items), .FullReload)
    }
    
    func resetData() {
        self.items.removeAll()
    }
    
    func reloadData() {
        self.dataSource?.stopInfiniteLoading(.FinishLoading)
    }
}

extension CustomerSocialViewController: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
        self.items.removeAll()
        self.dataSource?.updateAndReload(for: .SingleListing(items: self.items), .FullReload)
        let resultTitles = Common.socialCatalog
        var newResultTitles: [ModelOptionResponseSocialCatalogDatum] = resultTitles
        newResultTitles.insert(ModelOptionResponseSocialCatalogDatum(idNhomChuDe: 0, tenNhomChuDe: "Tất cả"), at: 0)
        if index == 0 {
            self.presenter?.originCustomerService()
        } else {
            self.presenter?.requestData.idNhomChuDe = newResultTitles[index].idNhomChuDe ?? 0
            self.presenter?.idNhomChuDe = newResultTitles[index].idNhomChuDe ?? 0
            self.presenter?.socialQuestionService()
        }
    }
}

extension CustomerSocialViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        //        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //        self.resetData()
        self.searhView.isHidden = true
        self.searchButton.isHidden = false
        //        self.presenter?.originCustomerService()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.resetData()
        self.searhView.isHidden = true
        self.searchButton.isHidden = false
        self.searchText = searchBar.text ?? ""
        self.presenter?.requestData.noiDung = self.searchText.lowercased()
        self.presenter?.socialQuestionService()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            self.searchText = ""
            // refresh data
            self.presenter?.originCustomerService()
        } else {
            self.resetData()
            self.searchText = searchBar.text ?? ""
            self.presenter?.requestData.noiDung = self.searchText.lowercased()
            self.presenter?.socialQuestionService()
        }
    }
}
