//
//  HospitalServiceDetailViewController.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 18/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

class HospitalServiceDetailViewController: BaseViewController<HospitalServicePresenter> {
    
    private let imHead = UIImageView()
    private let lbTitle = UILabel(text: "Khám bệnh theo yêu cầu", font: .customOpenSans(18, .bold), color: AppColors.textBlack, breakable: true)
//    private let lbDiscount = UILabel(text: "100.000 đ", font: .customOpenSans(18, .semiBold), color: AppColors.textBlue, breakable: true)
//    private let lbCash = UILabel(text: "300.000 đ", font: .customOpenSans(18, .semiBold), color: AppColors.gray, breakable: true)
//    private let lbContent = UILabel(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec congue orci nec gravida finibus. Proin ut dolor ut ante commodo pulvinar in et dui. Vestibulum eget libero in justo imperdiet vehicula. Quisque dictum eu diam nec blandit. Nunc nec massa nibh.", font: .customOpenSans(13, .regular), color: AppColors.textBlack, breakable: true)
    var data: SuggestionCustomerHomeOptionalResponse?
    
    override func initPresenter(with context: RouteContext?) {
//        super.initPresenter(with: context)
        presenter = HospitalServicePresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        data.
        presenter?.initDataPresenter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc private func actCreateDate() {
        if let model = presenter?.productDetail {
            self.openChildScreen(.CreateAppointmentViewController, fromStoryboard: .Appointment, withContext: RouteContext([CreateAppointmentPresenter.RV_LIST_SERVICE:model]))
        }
    }
}

extension HospitalServiceDetailViewController: HospitalServiceVC {
    
    func reloadData() {
        if let data = presenter?.productDetail {
            lbTitle.text = data.TenDichVu
//            lbContent.text = data
            lbDiscount.text = data.DonGia?.formatnumberWithCurrency()
        }
        if let data = presenter?.serviceDetail {
            lbTitle.text = data.TenDichVu
            lbDiscount.text = data.DonGia?.formatnumberWithCurrency()
        }
    }
}

extension HospitalServiceDetailViewController {
    private func setupUI() {
        self.view.backgroundColor = .white
        self.title = "Chi tiết dịch vụ khám"
        let scrollMain = UIScrollView()
        self.view.addSubview(scrollMain)
        scrollMain.snp.makeConstraints({
            $0.top.centerX.width.equalToSuperview()
        })
        
        scrollMain.addSubview(imHead)
        imHead.snp.makeConstraints({
            $0.centerX.width.top.equalToSuperview()
        })
        imHead.contentMode = .scaleAspectFit
        
        scrollMain.addSubview(lbTitle)
        lbTitle.snp.makeConstraints({
            $0.top.equalTo(ConstantsVal.edgePadding)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().offset(-ConstantsVal.widthPadding)
        })
        
        scrollMain.addSubview(lbDiscount)
        lbDiscount.snp.makeConstraints({
            $0.top.equalTo(lbTitle.snp.bottom).offset(ConstantsVal.edgePadding / 2)
            $0.leading.equalTo(lbTitle)
        })
        
        scrollMain.addSubview(lbCash)
        lbCash.snp.makeConstraints({
            $0.centerY.equalTo(lbDiscount)
            $0.trailing.equalTo(lbTitle)
        })
        
        scrollMain.addSubview(lbContent)
        lbContent.snp.makeConstraints({
            $0.centerX.width.equalTo(lbTitle)
            $0.top.equalTo(lbDiscount.snp.bottom).offset(ConstantsVal.edgePadding / 2)
            $0.bottom.equalToSuperview()
        })
        
        let btnSelect = UIButton(title: "Chọn dịch vụ", font: .customOpenSans(18, .bold), titleColor: .white, backColor: AppColors.textBlue, corner: 4)
        self.view.addSubview(btnSelect)
        btnSelect.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-ConstantsVal.edgePadding)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(42)
            $0.width.equalTo(126)
            $0.top.equalTo(scrollMain.snp.bottom).offset(ConstantsVal.edgePadding)
        })
        btnSelect.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.actCreateDate)))
        
    }
}
