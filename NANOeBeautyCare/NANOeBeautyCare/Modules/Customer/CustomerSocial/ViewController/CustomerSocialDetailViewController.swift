//
//  CustomerSocialDetailViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 11/10/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CustomerSocialDetailViewController: BaseViewController<CustomerSocialDetailPresenter> {
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    var searchText: String = ""
    var items: [ViewCustomerSocialDetail] = []
    private var dataSource: TableDataSource<ViewCustomerSocialDetail, CellViewCustomerSocialDetail, CustomerSocialDetailTableViewCell>?
    
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = CustomerSocialDetailPresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Chi tiết câu hỏi"
        self.presenter?.initDataPresent()
        self.backButtonNavigation()
        self.configureTableView()
        
        let gradient = CAGradientLayer()
        var bounds = self.navigationController?.navigationBar.bounds
        bounds?.size.height += UIApplication.shared.statusBarFrame.size.height
        gradient.frame = bounds ?? CGRect.zero
        gradient.colors = [AppColors.gradientStart.cgColor, AppColors.gradientMid.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        
        if let image = getImageFrom(gradientLayer: gradient) {
            self.navigationController?.navigationBar.shouldRemoveShadow(true)
            self.navigationController?.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
            self.navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17.0)]
            self.navigationController?.navigationBar.layoutIfNeeded()
            
        }
    }
    
    //
    
    private func configureTableView() {
        dataSource = TableDataSource<ViewCustomerSocialDetail, CellViewCustomerSocialDetail, CustomerSocialDetailTableViewCell>.init(.MultipleSection(items: self.items), tableView)
        
        dataSource?.addPullToRefresh = { [weak self] in
            self?.resetData()
            self?.presenter?.originCustomerService()
        }
        
        dataSource?.configureCell = { (cell, item, indexPath) in
            if indexPath.section == 0 {
                (cell as? CustomerQuestionTableViewCell)?.item = item
            } else {
                (cell as? CustomerAnserTableViewCell)?.item = item
            }
        }
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewCustomerSocialDetail) {
        
    }
    
    // MARK: - Action Button
    
}

// MARK: - Protocol of Presenter
extension CustomerSocialDetailViewController: CustomerSocialDetailVC {
    func initData(data: [ViewCustomerSocialDetail]) {
        self.items = data
        self.dataSource?.updateAndReload(for: .MultipleSection(items: self.items), .FullReload)
    }
    
    func reloadData() {
        self.dataSource?.stopInfiniteLoading(.FinishLoading)
    }
    
    func resetData() {
        //        self.items.removeAll()
    }
}


