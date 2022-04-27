//
//  HospitalContactTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 07/06/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

class HospitalContactInfoTableViewCell: UITableViewCell {
    static let id = "HospitalContactInfoTableViewCell"
    
    private var phone = DataManager.shared.companyModel?.DienThoai ?? ""
    
//    var selectedCall: () -> (Void)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.contentView.clipsToBounds = true
        let vContainer = CardView()
        vContainer.shadowColors = AppColors.gray
        vContainer.backgroundColor = .white
        self.contentView.addSubview(vContainer)
        vContainer.cornerradius = 4
        vContainer.clipsToBounds = true
        vContainer.snp.makeConstraints({
            $0.top.equalToSuperview().offset(4)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().offset(-36)
            $0.bottom.equalToSuperview().offset(-8)
        })
        
        let lbTitle = UILabel(text: "HOTLINE", font: .customOpenSans(16, .semiBold), color: AppColors.textBlue, breakable: false)
        vContainer.addSubview(lbTitle)
        lbTitle.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(12)
        })
        
        let vContact = UIView()
        vContainer.addSubview(vContact)
        vContact.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.top.greaterThanOrEqualTo(lbTitle.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().offset(-12)
            $0.height.equalTo(28)
        })
        vContact.layer.cornerRadius = 14
        vContact.clipsToBounds = true
        vContact.backgroundColor = AppColors.textBlue
//        vContact.setHorizontalGradient(startColor: AppColors.gradientStart, endColor: AppColors.gradientMid.withAlphaComponent(0.6))
        
        let icContact = UIImageView(image: UIImage(named: "ic_call_home"))
        vContact.addSubview(icContact)
        icContact.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(8)
            $0.height.equalToSuperview().offset(-8)
            $0.width.equalTo(icContact.snp.height)
        })
        icContact.contentMode = .scaleAspectFit
        
        let lbContact = UILabel(text: phone, font: UIFont.customOpenSans(16, .semiBoldItalic), color: .white, breakable: false)
        vContact.addSubview(lbContact)
        lbContact.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(icContact.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().offset(-12)
        })
        vContact.isUserInteractionEnabled = true
        vContact.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.actCall)))
        
//        vContainer.isUserInteractionEnabled = true
//        vContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.actCall)))
    }
    
    @objc func actCall() {
        if let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
