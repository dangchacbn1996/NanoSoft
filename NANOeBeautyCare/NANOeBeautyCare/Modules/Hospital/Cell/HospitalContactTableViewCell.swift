//
//  HospitalContactTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 18/05/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

class HospitalContactTableViewCell: UITableViewCell, ReusableCell {
    var item: CellViewHospitalMain?
    
    static let id = "HospitalContactTableViewCell"
    private let lbTitle = UILabel(text: "Thông tin liên hệ", font: .customOpenSans(16, .semiBold), color: AppColors.textRed)
    
    private let lbAddress = UILabel(text: "", font: .customOpenSans(16, .semiBold), color: AppColors.textBlack, breakable: true)
    private let lbTime = UILabel(text: "", font: .customOpenSans(16, .semiBold), color: AppColors.textBlack, breakable: true)
    private let lbEmail = UILabel(text: "", font: .customOpenSans(16, .semiBold), color: UIColor(hex: "3FADFC"), breakable: true)
    private let lbPhone = UILabel(text: "", font: .customOpenSans(16, .semiBold), color: UIColor(hex: "3FADFC"), breakable: true)
    private let lbWebsite = UILabel(text: "", font: .customOpenSans(16, .semiBold), color: UIColor(hex: "3FADFC"), breakable: true)
    private let lbTaxi = UILabel(text: "HOTLINE TAXI", font: .customOpenSans(16, .semiBold), color: AppColors.textRed, breakable: true)
    private var data: ResponseHospitalDetailModel? = nil
    
    typealias T = CellViewHospitalMain
//    var item: CellViewHospitalMain? {
//        didSet {
//            if let first = item?.property?.model?.contactResponse?.first {
//                self.bind(first)
//            }
//        }
//    }
//    var data: AgencyCustomerHomeOptionalResponse? = nil
    var services = HospitalService()
    var selectedTaxi: (() -> Void)? = nil
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func actTaxi() {
        
        selectedTaxi?()
    }
    
    @objc
    private func actPhone() {
        AppDelegate.actCall(tel: data?.DienThoai?.replace(string: " ", replacement: "") ?? "")
    }
    
    private func setupUI() {
        self.contentView.addSubview(lbTitle)
        lbTitle.snp.makeConstraints({
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(12)
        })
        
        let vContainer = CardView()
        self.contentView.addSubview(vContainer)
        vContainer.snp.makeConstraints({
            $0.top.equalTo(lbTitle.snp.bottom).offset(8)
            $0.centerX.bottom.equalToSuperview()
            $0.leading.equalTo(lbTitle)
            
        })
        vContainer.backgroundColor = .white
        
        func infoLine(icon: UIImage?, label: UILabel) -> (UIView) {
            let v = UIView()
            let image = UIImageView(image: icon?.withRenderingMode(.alwaysTemplate))
            v.addSubview(image)
            image.snp.makeConstraints({
                $0.top.leading.equalToSuperview()
                $0.size.equalTo(20)
                $0.height.lessThanOrEqualToSuperview()
            })
            image.contentMode = .scaleAspectFit
            image.tintColor = AppColors.textBlack
            v.addSubview(label)
            label.snp.makeConstraints({
                $0.centerY.equalToSuperview()
                $0.trailing.bottom.equalToSuperview()
                $0.leading.equalTo(image.snp.trailing).offset(8)
            })
            return v
        }
        let stackMain = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .fill, spacing: 8)
        vContainer.addSubview(stackMain)
        stackMain.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.size.equalToSuperview().offset(-12)
        })
        stackMain.addArrangedSubview(infoLine(icon: UIImage(named: "ic_address"), label: lbAddress))
        stackMain.addArrangedSubview(infoLine(icon: UIImage(named: "clock"), label: lbTime))
        stackMain.addArrangedSubview(infoLine(icon: UIImage(named: "ic_email"), label: lbEmail))
        
        let rowPhone = infoLine(icon: UIImage(named: "ic_call"), label: lbPhone)
        stackMain.addArrangedSubview(rowPhone)
        rowPhone.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.actPhone)))
        
        stackMain.addArrangedSubview(infoLine(icon: UIImage(named: "ic_website"), label: lbWebsite))
        let rowTaxi = infoLine(icon: UIImage(named: "ic_call"), label: lbTaxi)
        stackMain.addArrangedSubview(rowTaxi)
        rowTaxi.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.actTaxi)))
        
        if let data = DataManager.shared.companyModel {
            bind(data)
        }
    }
    
    func bind(_ data: ResponseHospitalDetailModel) {
        self.data = data
        lbAddress.text = data.DiaChiCongTy
        lbTime.text = "08h - 20h (Tất cả các ngày trong tuần)"
        lbEmail.text = data.Email
        lbPhone.text = data.DienThoai
        lbWebsite.text = data.Website
    }
}
