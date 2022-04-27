//
//  CustomerDetailViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/9/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CustomerDetailViewController: BaseViewController<CustomerDetailPresenter> {
    @IBOutlet weak var backgroudImageview: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    // MARK: - IBOutlet
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var avartaImageView: UIImageView!
    // Member
    @IBOutlet weak var numberLeverLabel: UILabel!
    @IBOutlet weak var titleLeverLabel: UILabel!



    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var reserveLabel: UILabel!
    @IBOutlet weak var waitingLabel: UILabel!
    @IBOutlet weak var cancelLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var moreInfomationButton: MyGradientButton!

    @IBOutlet weak var historyButton: MyGradientButton!

    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = CustomerDetailPresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //        self.title = "Navigation.CustomerDetail".localized
        self.presenter?.initDataPresent()
        
        self.backgroundView.roundCorners([.topLeft,.topRight], radius: 24.0)
        let gradient = CAGradientLayer()
        let bounds = self.view.bounds
        gradient.frame = bounds
        gradient.colors = [AppColors.gradientStart.cgColor, AppColors.gradientMid.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)

        if let image = getImageFrom(gradientLayer: gradient) {
            self.backgroudImageview.image = image
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //        self.navigationController?.navigationBar.isHidden = false
    }

    override func updatePanData(context: RouteContext) {
        super.updatePanData(context: context)
        self.presenter?.updatePanData(context: context)
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewCustomerDetail) {

    }
    
    // MARK: - Action Button
    @IBAction func backButton(_ sender: Any) {
        self.backToPrevScreen(with: RouteContext([RVIsReload: true]))
    }
    
    @IBAction func saveButton(_ sender: Any) {
        self.presenter?.updateCustomer()
    }

    @IBAction func moreInfomationButtonAction(_ sender: Any) {
        self.presenter?.goToMore()
    }

    @IBAction func historyButtonAction(_ sender: Any) {
        self.presenter?.goToHistory()
    }
}

// MARK: - Protocol of Presenter
extension CustomerDetailViewController: CustomerDetailVC {
    func initData(data: CustomerDetailOptionalResponse) {
        self.avartaImageView.avartaImageView(url: Common.stringToUrlImage(text: data.anhKhachHang ?? ""))

        self.numberLeverLabel.text = "\(data.tongDiemTichLuy ?? 0)"
        self.titleLeverLabel.text = data.tenHangThanhVien

        self.titleLabel.text = data.hoTen
        self.addressLabel.text = data.diaChi
        self.reserveLabel.text = "\(data.soLuongLichHen ?? 0)"
        self.waitingLabel.text = "\(data.choPhucVu ?? 0)"
        self.cancelLabel.text = "\(data.huyLichHen ?? 0)"
        self.birthdayLabel.text = data.ngaySinh
        self.sexLabel.text = data.tenGioiTinh
        self.typeLabel.text = data.loaiKhachHang
        self.noteLabel.text = data.ghiChu
    }

    func reloadData() {
    }
}


