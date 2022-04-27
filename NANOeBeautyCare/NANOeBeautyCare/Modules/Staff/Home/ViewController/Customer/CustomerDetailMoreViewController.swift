//
//  CustomerDetailMoreViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/20/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CustomerDetailMoreViewController: BaseViewController<CustomerDetailMorePresenter> {
    // MARK: - IBOutlet
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var facebookLabel: UILabel!
    @IBOutlet weak var sourceToLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!

    
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = CustomerDetailMorePresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Navigation.CustomerDetailMore".localized
        self.presenter?.initDataPresent()
        self.backButtonNavigation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewCustomerDetailMore) {

    }
    
    // MARK: - Action Button
    @IBAction func moreButtonAction(_ sender: Any) {
        self.openChildScreen(.TreatmentReportViewController, fromStoryboard: .Treatment, withContext: RouteContext(["URLContext":self.presenter?.dataContext?.urlLink,"IsCustomer":true]))
//
//        if let url = URL(string:
//                            Common.stringToUrlReport(text: self.presenter?.dataContext?.urlLink ?? "")) {
//            UIApplication.shared.open(url)
//        }
    }

}

// MARK: - Protocol of Presenter
extension CustomerDetailMoreViewController: CustomerDetailMoreVC {
    func initData(data: CustomerDetailOptionalResponse) {
        self.phoneLabel.text = data.dienThoai
        self.emailLabel.text = data.email
        self.facebookLabel.text = data.faceBook
        self.sourceToLabel.text = data.tenNguonDen
    }
    
    func reloadData() {
    }
}


