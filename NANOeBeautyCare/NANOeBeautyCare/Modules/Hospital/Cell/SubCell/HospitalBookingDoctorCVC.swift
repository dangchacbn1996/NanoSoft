//
//  HospitalBookingDoctorCVC.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 17/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

class HospitalBookingDoctorCVC: UICollectionViewCell {
    static let id = "HospitalBookingDoctorCVC"

    private let imAvatar = UIImageView(image: UIImage(named: AssetsName.defaultAvatar))
    private let lbName = UILabel(text: "J.Robert", font: .customOpenSans(12, .semiBold), color: UIColor(hex: "1A6CEE"))
    private let lbIntro = UILabel(text: "Chưởng khoa nhi viện Nhi TW", font: .customOpenSans(9, .regular), color: AppColors.textBlack, breakable: true)
    private let vChecked = UIView()
    private var data: ModelOptionResponseEmployeeAndSearchCatalogDatum? = nil
    var isChecked: Bool = false {
        didSet {
            vChecked.isHidden = !self.isChecked
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(_ data: ResponseDoctorByMajorModel) {
//        self.imAvatar.pictureSquareImageView(url: Common.stringToUrlImage(text: data.AnhNhanVien ?? ""))
        self.lbName.text = data.TenNhanVien
        self.lbIntro.text = data.NhomNhanVien
    }

    private func setupUI() {
        let vContainer = CardView()
        vContainer.shadowColors = AppColors.gray
        vContainer.backgroundColor = .white
        self.addSubview(vContainer)
        vContainer.cornerradius = 4
        vContainer.clipsToBounds = true
        vContainer.snp.makeConstraints({
            $0.top.leading.equalToSuperview().offset(4)
            $0.bottom.trailing.equalToSuperview().offset(-4)
        })
//        vContainer.dropShadow()
        vContainer.addSubview(imAvatar)
        imAvatar.snp.makeConstraints({
            $0.top.leading.trailing.equalToSuperview()
//            $0.height.equalToSuperview().multipliedBy(0.8)
//            $0.height.equalTo(imAvatar.snp.width).offset(1.2)
        })
        imAvatar.clipsToBounds = true
        imAvatar.contentMode = .scaleAspectFill
        vContainer.addSubview(lbName)
        lbName.snp.makeConstraints({
            $0.height.equalTo(32)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().offset(-8)
            $0.top.equalTo(imAvatar.snp.bottom).offset(4)
        })
        lbName.numberOfLines = 0
        lbName.textAlignment = .center
        vContainer.addSubview(lbIntro)
        lbIntro.snp.makeConstraints({
            $0.top.equalTo(lbName.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(24)
            $0.width.equalToSuperview().offset(-8)
            $0.bottom.equalToSuperview().offset(-4)
        })
        lbIntro.numberOfLines = 0
        lbIntro.textAlignment = .center
        
        vContainer.addSubview(vChecked)
        vChecked.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        vChecked.backgroundColor = AppColors.gray.withAlphaComponent(0.3)
        let ivChecked = UIImageView(image: UIImage(named: "ic-check-circle")?.withRenderingMode(.alwaysTemplate))
        vChecked.addSubview(ivChecked)
        ivChecked.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.size.equalTo(32)
        })
//        ivChecked = UIImageView(image: UIImage(named: "ic-check-circle")?.withRenderingMode(.alwaysTemplate))
        ivChecked.tintColor = AppColors.primaryColor
        ivChecked.contentMode = .scaleAspectFit
        vChecked.isHidden = true
//        ivChecked = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
//        ivChecked.snp.makeConstraints({
//            $0.edges.equalToSuperview()
//        })
    }
}
