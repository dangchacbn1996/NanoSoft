//
//  CustomerHomeNewsFilterViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 24/11/2020
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit
import JXSegmentedView

class CustomerHomeNewsFilterViewController: BaseViewController<CustomerHomeNewsFilterPresenter> {
    // MARK: - IBOutlet
    @IBOutlet weak var backgroundViewColor: UIView!
    @IBOutlet weak var titleNavigation: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searhView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!

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
    @IBAction func backButton(_ sender: Any) {
        self.backToPrevScreen()
    }

    var segmentedDataSource: JXSegmentedTitleImageDataSource!
    var listContainerView: JXSegmentedListContainerView!
    var searchText: String = ""
    @IBOutlet weak var listSocial: JXSegmentedView!
    
    @IBOutlet weak var tableView: UITableView!
    var items: [NewCustomerHomeOptionalResponse] = []
    private var dataSource: TableDataSource<DefaultHeaderFooterModel<NewCustomerHomeOptionalResponse>,
                                            DefaultCellModel<NewCustomerHomeOptionalResponse>,
                                            NewCustomerHomeOptionalResponse>?

    var dataCate: [NewCustomerHomeOptionalResponse] = []

    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = CustomerHomeNewsFilterPresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.presenter?.initDataPresent()
        self.configureTableView()
        let gradient = CAGradientLayer()
        let bounds = self.view.bounds
        gradient.frame = bounds
        gradient.colors = [AppColors.gradientStart.cgColor, AppColors.gradientMid.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)

        if let image = getImageFrom(gradientLayer: gradient) {
            self.listSocial.removeShadow()
            self.listSocial.backgroundColor = UIColor.clear
            self.backgroundViewColor.backgroundColor = UIColor(patternImage: image)
        }


        searchBar.showsCancelButton = true
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        searchBar.delegate = self

        self.titleNavigation.text = "Tin tức"


        segmentedDataSource = JXSegmentedTitleImageDataSource()
        segmentedDataSource.titleSelectedColor = AppColors.primaryColor
        segmentedDataSource.titleNormalColor = .white
        segmentedDataSource.isTitleColorGradientEnabled = true
        segmentedDataSource.titleImageType = . leftImage
        segmentedDataSource.isImageZoomEnabled = true

        let indicator = JXSegmentedIndicatorBackgroundView()
        indicator.indicatorHeight = 35
        indicator.indicatorCornerRadius = 4
        
        indicator.indicatorWidthIncrement = 15
        indicator.indicatorColor = UIColor.white
        listSocial.indicators = [indicator]

        listSocial.delegate = self
    }

    // MARK: - TableView Setup
    private func configureTableView() {
        dataSource = TableDataSource<DefaultHeaderFooterModel<NewCustomerHomeOptionalResponse>, DefaultCellModel<NewCustomerHomeOptionalResponse>, NewCustomerHomeOptionalResponse>.init(.SingleListing(items: items, identifier: CustomerHomeNewsFilterTableViewCell.identfier, height: 110.0, leadingSwipe: nil, trailingSwipe: nil), tableView)

        dataSource?.configureCell = { (cell, item, indexPath) in
            (cell as? CustomerHomeNewsFilterTableViewCell)?.item = item
        }

        dataSource?.addPullToRefresh = { [weak self] in
            self?.resetData()
            self?.presenter?.services()
        }

        dataSource?.addInfiniteScrolling = { [weak self] (page) in
            //            self?.presenter?.requestSuggestionCustomer.tenDichVu = self?.searchText ?? ""
            //            self?.presenter?.requestSuggestionCustomer.pageNum = page
            self?.presenter?.services()
        }
        dataSource?.didSelectRow = { (indexPath, item) in
            if let model = item?.property?.model {
                self.openChildScreen(.CustomerHomeNewsViewController, fromStoryboard: .CustomerHome, withContext: RouteContext([RVContext:model]))
            }
        }
    }

    // MARK: - Update Data IBOutlet
    func updateData(data: ViewCustomerHomeNewsFilter) {

    }


    func getTitles() -> [String] {
        var resultTitles = self.dataCate.map({$0.tenNhomNews ?? ""})
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

    override func viewWillAppear(_ animated: Bool) { // As soon as vc appears
        super.viewWillAppear(true)

        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) { // As soon as vc disappears
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    // MARK: - Action Button

}
extension CustomerHomeNewsFilterViewController: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
        self.items.removeAll()
        self.dataSource?.updateAndReload(for: .SingleListing(items: self.items), .FullReload)
        let resultTitles = self.dataCate
        if index == 0 {
            self.presenter?.requestNewCustomer.idNhomNews = 0
            self.presenter?.categoryService()
        } else {
            if index == 0 {
                self.presenter?.requestNewCustomer.idNhomNews = 0
                self.presenter?.categoryService()
            } else {
                self.presenter?.requestNewCustomer.idNhomNews = resultTitles[index-1].idNhomNews ?? 0
                self.presenter?.services()
            }
        }
    }
}

// MARK: - Protocol of Presenter
extension CustomerHomeNewsFilterViewController: CustomerHomeNewsFilterVC {
    func initCategaryData(data: [NewCustomerHomeOptionalResponse]) {
        self.dataCate = data
        DispatchQueue.main.async {
            self.segmentedDataSource.titles = self.getTitles()
            self.segmentedDataSource.normalImageInfos = self.getImageTitle()
            self.segmentedDataSource.loadImageClosure = {(imageView, normalImageInfo) in
                imageView.image = UIImage(named: normalImageInfo)
            }
            self.segmentedDataSource.selectedImageInfos = self.getImageSelectedTitle()

            self.listSocial.dataSource = self.segmentedDataSource
            self.listSocial.listContainer = self.listContainerView
            self.listSocial.reloadData()
        }

    }
    
    func resetData() {
        self.items.removeAll()
    }

    func initData(data: [NewCustomerHomeOptionalResponse]) {
        self.items.removeAll()
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

    func reloadData() {
        self.dataSource?.stopInfiniteLoading(.FinishLoading)
    }

}

extension CustomerHomeNewsFilterViewController: UISearchBarDelegate {
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
        self.presenter?.requestNewCustomer.tieuDe = self.searchText.lowercased()
        self.presenter?.services()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            self.searchText = ""
            // refresh data
            self.presenter?.categoryService()
        } else {
            self.resetData()
            self.searchText = searchBar.text ?? ""
            self.presenter?.requestNewCustomer.tieuDe = self.searchText.lowercased()
            self.presenter?.services()
        }
    }
}

extension UIView {

    func shadow(_ height: Int = 5) {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0 , height: height)
    }

    func removeShadow() {
        self.layer.shadowOffset = CGSize(width: 0 , height: 0)
        self.layer.shadowColor = UIColor.clear.cgColor
        self.layer.cornerRadius = 0.0
        self.layer.shadowRadius = 0.0
        self.layer.shadowOpacity = 0.0
    }
}
