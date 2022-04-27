//
//  HospitalBookingTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 17/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit
import ActionSheetPicker_3_0

class HospitalBookingTableViewCell: UITableViewCell, ReusableCell {
    
    static let id = "HospitalBookingTableViewCell"

    private let lbSpecialist = UILabel(font: .customOpenSans(14, .semiBold), color: UIColor(hex: "3B3A43"), breakable: true)
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
//    private var listData: [SuggestionCustomerHomeOptionalResponse] = []
    private let lbChooseMajor = UILabel(text: "Chọn khoa", font: .customOpenSans(14, .semiBold), color: UIColor(hex: "616066"))
    private var vChooseMajor = UIView()
    private var lbGuide = UILabel(text: "Vui lòng chọn khoa!", font: .customOpenSans(14, .semiBold), color: AppColors.gray, breakable: true)
    private let lbDes = UILabel(text: "Chọn bác sĩ chuyên khoa:", font: UIFont.customOpenSans(16, .semiBold), color: AppColors.textBlack)
    private let btnBook = UIButton()
    
    var delegate: HospitalMainCellDelegate? = nil
    var selectedMajor: ((ResponseMajorModel) -> Void)?
    var bookingDoctor: ((ResponseDoctorByMajorModel?) -> Void)?
    var item: CellViewHospitalMain?
    private var selectedIndex: Int? = nil {
        willSet {
            if selectedIndex != nil {
                (collectionView.cellForItem(at: IndexPath(item: selectedIndex!, section: 0)) as? HospitalBookingDoctorCVC)?.isChecked = false
            }
        }
    }
    
    private var selectedMajorModel: ResponseMajorModel? = nil {
        didSet {
            if selectedMajorModel != nil {
                self.selectedMajor?(selectedMajorModel!)
            }
        }
    }
    
    private var selectedDoctor: ResponseDoctorByMajorModel? = nil
//    {
//        didSet {
//            btnBook.isUserInteractionEnabled = selectedDoctor != nil
//            if selectedDoctor != nil {
//                btnBook.setLinearGradient(startColor: AppColors.gradientRed.start, endColor: AppColors.gradientRed.end).cornerRadius = 10
//            } else {
//                (btnBook.layer.sublayers?.first as? CAGradientLayer)?.removeFromSuperlayer()
//                btnBook.backgroundColor = AppColors.gray
//            }
//        }
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateModel(model: [ResponseDoctorByMajorModel]) {
        self.selectedIndex = nil
        self.selectedDoctor = nil
        self.item?.property?.model?.doctorByMajor = model
        delegate?.reloadLayoutTable(handler: { () -> (Void) in
            collectionView.isHidden = (self.item?.property?.model?.doctorByMajor?.count ?? 0) == 0
            lbDes.isHidden = collectionView.isHidden
//            btnBook.isHidden = collectionView.isHidden
        })
        collectionView.reloadData()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        if let gradient = UIView.gradientImage(for: btnBook, start: AppColors.gradientRed.start, end: AppColors.gradientRed.end, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1)) {
            btnBook.setImage(gradient, for: .normal)
        }
        else {
            btnBook.backgroundColor = AppColors.viewRed
        }
//        btnBook.setLinearGradient(startColor: AppColors.gradientRed.start, endColor: AppColors.gradientRed.end).cornerRadius = 4
    }
    
    private func reloadCollection() {
//        delegate?.reloadLayoutTable(handler: { () -> (Void) in
//            if (self.item?.property?.model?.doctorByMajor?.count ?? 0) == 0 {
//                collectionView.snp.makeConstraints({
//                    $0.height.equalTo(0)
//                })
//            } else {
//                collectionView.snp.makeConstraints({
//                    $0.height.equalTo(132)
//                })
//            }
//            collectionView.reloadData()
//        })
    }

    private func setupUI() {
        self.backgroundColor = .clear
        let icBooking = UIImageView(image: UIImage(named: AssetsName.icHeaderBooking))
        self.contentView.addSubview(icBooking)
        icBooking.snp.makeConstraints({
            $0.height.equalTo(24)
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(10)
        })
        icBooking.contentMode = .scaleAspectFit

        let lbTitle = UILabel(text: "Đặt lịch hẹn", font: .customOpenSans(20, .bold), color: UIColor(hex: "EE1A1A"))
        self.contentView.addSubview(lbTitle)
        lbTitle.snp.makeConstraints({
            $0.leading.equalTo(icBooking.snp.trailing).offset(8)
            $0.centerY.equalTo(icBooking)
        })

        func selectRow(icon: UIImage?, label: UILabel) -> (UIView) {
            let selectView = UIView()
            selectView.backgroundColor = AppColors.primaryColor.withAlphaComponent(0.2)
            selectView.snp.makeConstraints({
                $0.height.equalTo(36)
            })
            selectView.clipsToBounds = true
            selectView.layer.cornerRadius = 14
            selectView.addSubview(label)
            label.snp.makeConstraints({
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().offset(10)
            })

            let icDropdown = UIImageView(image: UIImage(named: AssetsName.icDropdown)?.withRenderingMode(.alwaysTemplate))
            icDropdown.tintColor = UIColor(hex: "1A6CEE")
            selectView.addSubview(icDropdown)
            icDropdown.snp.makeConstraints({
                $0.centerY.equalToSuperview()
                $0.height.equalToSuperview().multipliedBy(0.8)
                $0.trailing.equalToSuperview().offset(-16)
                $0.width.equalTo(16)
                $0.leading.equalTo(label.snp.trailing).offset(8)
            })
            icDropdown.contentMode = .scaleAspectFit
            return selectView
        }

        vChooseMajor = selectRow(icon: nil, label: lbChooseMajor)
        vChooseMajor.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.actShowMajor)))
        self.contentView.addSubview(vChooseMajor)
        vChooseMajor.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().offset(-20)
            $0.top.equalTo(icBooking.snp.bottom).offset(8)
        })

//        self.contentView.addSubview(lbDes)
//        lbDes.snp.makeConstraints({
//            $0.leading.equalToSuperview().offset(10)
//            $0.top.equalTo(vChooseMajor.snp.bottom).offset(8)
//        })
        
        let stackView = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .center, spacing: 12)
        self.contentView.addSubview(stackView)
        stackView.snp.makeConstraints({
            $0.centerX.width.equalToSuperview()
            $0.top.equalTo(vChooseMajor.snp.bottom).offset(12)
            $0.bottom.equalToSuperview().offset(-ConstantsVal.edgePadding)
        })
        
        stackView.addArrangedSubview(lbDes)
        lbDes.snp.makeConstraints({
            $0.width.equalToSuperview().offset(-ConstantsVal.widthPadding)
        })

//        self.contentView.addSubview(collectionView)
//        collectionView.snp.makeConstraints({
//            $0.top.equalTo(lbDes.snp.bottom).offset(8)
//            $0.height.equalTo(0)
//            $0.leading.trailing.equalToSuperview()
//        })
        stackView.addArrangedSubview(collectionView)
        collectionView.snp.makeConstraints({
            $0.width.equalToSuperview()
            $0.height.equalTo(160)
        })
        lbDes.isHidden = true
        collectionView.isHidden = true
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
        collectionView.backgroundColor = .clear
        collectionView.allowsSelection = true
        collectionView.register(HospitalBookingDoctorCVC.self, forCellWithReuseIdentifier: HospitalBookingDoctorCVC.id)
        collectionView.delegate = self
        collectionView.dataSource = self
        
//        self.contentView.addSubview(lbGuide)
//        lbGuide.snp.makeConstraints({
//            $0.center.equalTo(collectionView)
//        })

        stackView.addArrangedSubview(btnBook)
        btnBook.snp.makeConstraints({
            $0.height.equalTo(50)
            $0.width.equalTo(200)
        })
        
        btnBook.addSubView(UIView()) { content in
            content.snp.makeConstraints({
                $0.center.equalToSuperview()
                $0.height.equalToSuperview()
            })
            let icon = UIImageView(image: UIImage(named: "ic-phone-call"))
            content.addSubview(icon)
            icon.snp.makeConstraints({
                $0.centerY.height.equalToSuperview()
                $0.leading.equalToSuperview()
                $0.width.equalTo(24)
            })
            icon.contentMode = .scaleAspectFit
            
            let lbBook = UILabel(text: "Đặt hẹn", font: UIFont.customOpenSans(20, .semiBold), color: .white, breakable: false)
            content.addSubview(lbBook)
            lbBook.snp.makeConstraints({
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview()
                $0.leading.equalTo(icon.snp.trailing).offset(8)
            })
        }
        
        btnBook.clipsToBounds = true
        btnBook.layer.cornerRadius = 10
        btnBook.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.actSelect)))
        
        selectedDoctor = nil
    }

//    func bind(_ data: [SuggestionCustomerHomeOptionalResponse]) {
//        self.listData = data
//    }

    @objc private func actShowMajor() {
        if let list = self.item?.property?.model?.majorHospital {
            let listItem = list.map({
                "\($0.Ten ?? "")"
            })
            ActionSheetStringPicker(title: "Chọn khoa", rows: listItem, initialSelection: 0, doneBlock: { (picker, index, value) in
                self.lbChooseMajor.text = (value as? String) ?? ""
                self.selectedMajorModel = list[index]
                self.selectedDoctor = nil
            }, cancel: nil, origin: self.vChooseMajor).show()
        }
    }
    
    @objc private func actSelect() {
        if selectedMajorModel == nil {
            CommonView.alert(title: "Thông báo", description: "Vui lòng chọn khoa khám bệnh")
            return
        }
        if selectedDoctor == nil {
            CommonView.alert(title: "Thông báo", description: "Vui lòng chọn bác sĩ chuyên khoa")
            return
        }
        bookingDoctor?(selectedDoctor)
    }
}

extension HospitalBookingTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HospitalBookingDoctorCVC.id, for: indexPath)
        if let data = self.item?.property?.model?.doctorByMajor?[indexPath.row] {
            (cell as? HospitalBookingDoctorCVC)?.bind(data)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = self.item?.property?.model?.doctorByMajor?.count ?? 0
        lbGuide.isHidden = count != 0
        return count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.contentView.bounds.width - 50) / 3.5, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let doctor = item?.property?.model?.doctorByMajor?[indexPath.item] {
            (collectionView.cellForItem(at: indexPath) as? HospitalBookingDoctorCVC)?.isChecked = true
            if selectedIndex != indexPath.item {
                self.selectedIndex = indexPath.item
            }
            self.selectedDoctor = doctor
        }
    }
}
