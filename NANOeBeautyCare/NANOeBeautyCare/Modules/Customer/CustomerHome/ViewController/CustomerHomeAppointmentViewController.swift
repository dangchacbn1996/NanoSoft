//
//  CustomerHomeAppointmentViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 10/10/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit
import RichTextView

class CustomerHomeAppointmentViewController: BaseViewController<CustomerHomeAppointmentPresenter> {
    // MARK: - IBOutlet
    @IBOutlet weak var pictureImageview: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var appointmentButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var originPriceLabel: UILabel!
    @IBOutlet weak var discountPriceLabel: UILabel!
    @IBOutlet weak var htmlView: RichTextView!
    @IBOutlet weak var htmlTextView: UITextView!
    var data: SuggestionCustomerHomeOptionalResponse?
    
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = CustomerHomeAppointmentPresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chi tiết"
        self.edgesForExtendedLayout = .init()
        // Do any additional setup after loading the view.
        //        self.title = "Navigation.CustomerHomeAppointment".localized
        self.backButtonNavigation()
        self.presenter?.initDataPresent()
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewCustomerHomeAppointment) {

    }
    
    // MARK: - Action Button
    @IBAction func callButtonAction(_ sender: Any) {
//        Common.callNumber(phoneNumber: self.data.d)
    }

    @IBAction func appointmentButtonActiopn(_ sender: Any) {
        if Common.IS_GUEST {
            self.alertGuest()
        } else {
            self.openChildScreen(.CreateAppointmentViewController, fromStoryboard: .Appointment, withContext: RouteContext(["RVContextCustomer":self.data]))
        }
    }


}

// MARK: - Protocol of Presenter
extension CustomerHomeAppointmentViewController: CustomerHomeAppointmentVC {
    func initData(data: SuggestionCustomerHomeOptionalResponse) {
        self.data = data
        self.pictureImageview.pictureImageView(url: Common.stringToUrlImage(text: data.anhDichVu ?? ""))
        self.titleLabel.text = data.tenDichVu
        self.descLabel.text = data.tomTat
        self.originPriceLabel.text = data.donGianNiemYet?.formatnumberWithCurrency()
        self.discountPriceLabel.attributedText = data.donGia?.formatnumberWithCurrency().strikeThrough()

        //        self.descTextview.attributedText = data.noiDung?.set(style: Common.styleGroup())
        // Render
//        htmlView.update(input: data.noiDung?.replace(string: "\\\"", replacement: "\""),
//
//                        font: UIFont.systemFont(ofSize: 17.0)
//        )
        self.htmlTextView.htmlText = data.noiDung ?? ""
        self.htmlTextView.adjustUITextViewHeight()

        
//        print(data.noiDung?.replace(string: "\\\"", replacement: "\""))
        //        self.descTextview?.attributedText = data.noiDung?.set(style: StyleGroup())
    }
    
    func reloadData() {
    }
}


