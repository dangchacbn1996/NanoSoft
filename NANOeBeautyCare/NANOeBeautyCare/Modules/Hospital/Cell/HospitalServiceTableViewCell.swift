//
//  HospitalServiceTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 17/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

class HospitalServiceTableViewCell: UITableViewCell, ReusableCell {
    
    static let id = "HospitalServiceTableViewCell"
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let pageControl = UIPageControl()
    
    typealias T = CellViewHospitalMain
    var item: CellViewHospitalMain? {
        didSet {
            pageControl.numberOfPages = 1 + (item?.property?.model?.serviceHospital?.count ?? 0) / 4
            collectionView.reloadData()
            print("page: total: \(pageControl.numberOfPages)")
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var selectedService: ((ResponseComboServiceModel) -> Void)?

    @objc func actSelect() {
//        let vc = HospitalVIPListServiceViewController()
//        self.parent?.navigationController?.pushViewController(vc, animated: true)

    }

    private func setupUI() {
        self.backgroundColor = .clear
        let lbTitle = UILabel(text: "Dịch vụ", font: .customOpenSans(16, .semiBold), color: AppColors.textBlack)
        self.contentView.addSubview(lbTitle)
        lbTitle.snp.makeConstraints({
            $0.leading.equalToSuperview().offset(ConstantsVal.edgePadding)
            $0.top.equalToSuperview().offset(ConstantsVal.edgePadding)
        })

        let lbDescription = UILabel(text: "Gói khám sức khoẻ", font: UIFont.customOpenSans(12, .semiBold), color: AppColors.textBlue)
        self.contentView.addSubview(lbDescription)
        lbDescription.snp.makeConstraints({
            $0.leading.equalTo(lbTitle)
            $0.top.equalTo(lbTitle.snp.bottom).offset(4)
        })

        let vService = UIView()
        self.contentView.addSubview(vService)
        vService.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(lbTitle)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(vService.snp.width).multipliedBy(0.6)
            $0.top.equalTo(lbDescription.snp.bottom).offset(8)
        })
        vService.layer.cornerRadius = 10
        vService.clipsToBounds = true
        let imageService = UIImageView(image: UIImage(named: "im_service"))
        vService.addSubview(imageService)
        imageService.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        imageService.clipsToBounds = true
        imageService.contentMode = .scaleAspectFill
        
        vService.addSubview(collectionView)
        collectionView.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.height.equalToSuperview().offset(-ConstantsVal.widthPadding)
            $0.leading.equalToSuperview().offset(ConstantsVal.edgePadding)
//            $0.width.equalToSuperview().multipliedBy(0.7)
//            $0.height.equalTo(self.snp.width).multipliedBy(2/3).offset(-820/3)
        })
//        collectionView.contentInset = UIEdgeInsets(top: 0, left: ConstantsVal.edgePadding, bottom: 0, right: ConstantsVal.edgePadding)
//        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
        collectionView.backgroundColor = .clear
        
        collectionView.register(HospitalServiceCollectionViewCell.self, forCellWithReuseIdentifier: HospitalServiceCollectionViewCell.id)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        vService.addSubview(pageControl)
        pageControl.snp.makeConstraints({
            $0.centerX.equalTo(collectionView)
            $0.bottom.equalToSuperview()
            $0.top.equalTo(collectionView.snp.bottom)
        })
    }
}

extension HospitalServiceTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return item?.property?.model?.serviceHospital?.count ?? 0
        return item?.property?.model?.serviceHospital?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return ConstantsVal.edgePadding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ConstantsVal.edgePadding
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HospitalServiceCollectionViewCell.id, for: indexPath) as! HospitalServiceCollectionViewCell
        if let model = item?.property?.model?.serviceHospital?[indexPath.item] {
            cell.bind(data: model)
        }
//        cell.bind(data: ResponseComboServiceModel.demoModel())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        selectedProduct?(ResponseProductModel.demoData())
//        selectedService?(ResponseComboServiceModel.demoModel())
        if let model = item?.property?.model?.serviceHospital?[indexPath.item] {
            selectedService?(model)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.contentView.bounds.width) / 2 - 40
        let height = (self.contentView.bounds.height - (50 + 4 * ConstantsVal.edgePadding)) / 2
        return CGSize(width: width, height: height)
//        return CGSize(width: 100, height: 100)
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let page = Int(scrollView.contentOffset.x) / Int(scrollView.contentSize.width)
//        print("page: \(page)")
//        pageControl.currentPage = page
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
}

class HospitalServiceCollectionViewCell : UICollectionViewCell {
    
    static let id = "HospitalServiceCollectionViewCell"
    
    private let lbTitle = UILabel(text: "Dịch vụ", font: UIFont.customOpenSans(14, .semiBold), color: UIColor.orange, breakable: true)
    private let lbPrice = UILabel(text: "", font: UIFont.customOpenSans(14, .semiBold), color: UIColor.red, breakable: false)
    
    private var data: ResponseComboServiceModel? {
        didSet {
            self.lbTitle.text = data?.TenComboGoiDVSP ?? ""
            self.lbPrice.text = data?.GiaBan?.formatnumberWithCurrency() ?? ""
//            self.image.pictureSquareImageView(url: Common.stringToUrlImage(text: data?.Icon ?? ""))
        }
    }
    
    func bind(data: ResponseComboServiceModel?) {
        self.data = data
//        switch index % 3 {
//        case 0:
//            v.backgroundColor = UIColor(hex: "FFD65C")
//            break
//        case 1:
//            v.backgroundColor = UIColor(hex: "C0CB45")
//            break
//        default:
//            v.backgroundColor = UIColor(hex: "FFA83D")
//        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        let v = UIView()
        v.layer.cornerRadius = 8
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.orange.cgColor
        v.backgroundColor = .white
//        v.addSubview(image)
//        image.snp.makeConstraints({
//            $0.centerX.equalToSuperview()
//            $0.top.equalToSuperview().offset(8)
//            $0.height.equalTo(32)
//        })
//        image.contentMode = .scaleAspectFit

        v.addSubview(lbTitle)
        lbTitle.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(12)
            $0.width.equalToSuperview().offset(-16)
        })
        lbTitle.textAlignment = .center
        lbTitle.numberOfLines = 2
//        v.snp.makeConstraints({
//            $0.width.equalTo(v.snp.height)
//        })
        v.addSubview(lbPrice)
        lbPrice.snp.makeConstraints({
            $0.top.equalTo(lbTitle.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(lbTitle)
            $0.bottom.equalToSuperview().offset(-16)
        })
        lbPrice.textAlignment = .center
        self.contentView.addSubview(v)
        v.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
}
