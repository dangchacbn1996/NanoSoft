//
//  HospitalProductTypeViewCell.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 17/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

class HospitalProductTypeTableViewCell: UITableViewCell, ReusableCell {
    
    typealias T = CellViewHospitalMain
    
    static let id = "HospitalProductTypeTableViewCell"
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var item: CellViewHospitalMain?
    var selectedProduct: ((ResponseProductModel) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateModel(model: NewCustomerHomeOptionalResponse) {
//        self.categoryTitleLabel.text = model.tenNhomNews
//        self.dateLabel.text = model.ngayCapNhat
//        self.avartaImageview.pictureSquareImageView(url: Common.stringToUrlImage(text: model.anhDaiDien ?? ""))
//        self.descLabel.text = model.tieuDe
    }

    func setupUI() {
        self.backgroundColor = .clear
        
        self.contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints({
            $0.centerX.width.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-8)
            $0.top.equalToSuperview().offset(ConstantsVal.edgePadding)
            $0.height.equalTo(230)
//            $0.height.equalTo(self.snp.width).multipliedBy(2/3).offset(-820/3)
        })
        collectionView.contentInset = UIEdgeInsets(top: 0, left: ConstantsVal.edgePadding, bottom: 0, right: ConstantsVal.edgePadding)
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .vertical
        collectionView.backgroundColor = .clear
        
        collectionView.register(HospitalProductCollectionViewCell.self, forCellWithReuseIdentifier: HospitalProductCollectionViewCell.id)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension HospitalProductTypeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (item?.property?.model?.suggestionCustomer?.count ?? 0) + 2
//        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return ConstantsVal.edgePadding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ConstantsVal.edgePadding * 1.5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HospitalProductCollectionViewCell.id, for: indexPath) as! HospitalProductCollectionViewCell
        cell.bind(data: getModelBy(item: indexPath.item), index: indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let data = item?.property?.model?.suggestionCustomer?[indexPath.item] {
            selectedProduct?(getModelBy(item: indexPath.item))
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.collectionView.bounds.width - (10 + 4 * ConstantsVal.edgePadding)) / 3
        return CGSize(width: width, height: width)
    }
    
    func getModelBy(item: Int) -> (ResponseProductModel) {
        if item < 2 {
            if let data = self.item?.property?.model?.suggestionCustomer?[item] {
                return data
            }
        }
        if item == 2 {
            let data = ResponseProductModel()
            data.TenLoaiDichVu = "Tra cứu bệnh án"
            data.IDLoaiDV = HospitalProductCollectionViewCell.INDEX_FILE
            return data
        }
        if item > 2 && item < 5 {
            if let data = self.item?.property?.model?.suggestionCustomer?[item - 1] {
                return data
            }
        }
        if item == 5 {
            let data = ResponseProductModel()
            data.TenLoaiDichVu = "Hỏi đáp với bác sĩ"
            data.IDLoaiDV = HospitalProductCollectionViewCell.INDEX_COMMUTY
            return data
        }
        let data = self.item?.property?.model?.suggestionCustomer?[item - 2] ?? ResponseProductModel()
        return data
    }
    
}

class HospitalProductCollectionViewCell : UICollectionViewCell {
    
    static let INDEX_FILE = -1000
    static let INDEX_COMMUTY = -1001
    
    static let id = "HospitalProductCollectionViewCell"
    
    private let lbTitle = UILabel(text: "Dịch vụ", font: UIFont.customOpenSans(12, .regular), color: AppColors.textBlack, breakable: true)
    private let image = UIImageView(image: UIImage(named: "ic_kit"))
//    private var title: String = "Dich vu"
    private var backColor: UIColor = UIColor.white
    private var icon: UIImage? = UIImage(named: "ic_contact")
    private let v = CardView()
    
    private var data: ResponseProductModel? {
        didSet {
            self.lbTitle.text = data?.TenLoaiDichVu ?? ""
            switch data?.IDLoaiDV {
            case 1:
                image.image = UIImage(named: "ic_kit")
            case 2:
                image.image = UIImage(named: "ic_bed")
            case 3:
                image.image = UIImage(named: "ic_company")
            case 4:
                image.image = UIImage(named: "ic_ambulance")
            case HospitalProductCollectionViewCell.INDEX_FILE:
                image.image = UIImage(named: "ic_docs")
            case HospitalProductCollectionViewCell.INDEX_FILE:
                image.image = UIImage(named: "ic_contact")
            default:
                image.image = UIImage(named: "ic_kit")
            }
//            self.image.pictureSquareImageView(url: Common.stringToUrlImage(text: data?.Icon ?? ""))
        }
    }
    
    func bind(data: ResponseProductModel?, index: Int) {
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
        v.shadowColors = UIColor.gray
        v.layer.cornerRadius = 8
        v.backgroundColor = backColor
        v.addSubview(image)
        image.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(8)
            $0.height.equalTo(36)
        })
        image.contentMode = .scaleAspectFit

        v.addSubview(lbTitle)
        lbTitle.snp.makeConstraints({
            $0.top.equalTo(image.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().offset(-8)
            $0.bottom.equalToSuperview().offset(-8)
        })
        lbTitle.textAlignment = .center
//        v.snp.makeConstraints({
//            $0.width.equalTo(v.snp.height)
//        })
        
        self.contentView.addSubview(v)
        v.snp.makeConstraints({
            $0.centerX.width.bottom.equalToSuperview()
            $0.top.equalToSuperview().offset(2)
        })
    }
}
