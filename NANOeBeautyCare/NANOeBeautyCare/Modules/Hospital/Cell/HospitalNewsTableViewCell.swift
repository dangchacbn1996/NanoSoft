//
//  HospitalNewsTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 15/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

class HospitalNewsTableViewCell: UITableViewCell, ReusableCell {
    
    static let id = "HospitalNewsTableViewCell"
    
    private let lbSpecialist = UILabel(font: .customOpenSans(14, .semiBold), color: UIColor(hex: "3B3A43"), breakable: true)
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let btnMore = UIButton(title: "(Xem thêm)", font: .customOpenSans(14, .bold), titleColor: AppColors.textBlue, backColor: .clear, corner: 0)
    
    typealias T = CellViewHospitalMain
    
    private var data: [NewCustomerHomeOptionalResponse] = []
    
    var item: CellViewHospitalMain? {
        didSet {
            let model = item?.property?.model
            self.data = model?.newCustomer ?? []
//            self.titleLabel.text = "Tin tức"
        }
    }
    
    var selectedData: ((NewCustomerHomeOptionalResponse) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
//    override func viewDidLoad() {
//        super.viewDidLoad()
        self.backgroundColor = .clear
        let lbTitle = UILabel(text: "Tin tức", font: .customOpenSans(16, .semiBold), color: AppColors.textBlack)
        self.contentView.addSubview(lbTitle)
        lbTitle.snp.makeConstraints({
            $0.leading.equalToSuperview().offset(ConstantsVal.edgePadding)
            $0.top.equalToSuperview().offset(ConstantsVal.edgePadding)
        })

        self.contentView.addSubview(btnMore)
        btnMore.snp.makeConstraints({
            $0.trailing.equalToSuperview().offset(-ConstantsVal.edgePadding)
            $0.centerY.equalTo(lbTitle)
        })

        self.contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints({
            $0.top.equalTo(lbTitle.snp.bottom).offset(8)
            $0.height.equalTo(255)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        })
        collectionView.contentInset = UIEdgeInsets(top: 0, left: ConstantsVal.edgePadding, bottom: 0, right: ConstantsVal.edgePadding)
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
        collectionView.backgroundColor = .clear
        collectionView.register(CustomerNewsCVC.self, forCellWithReuseIdentifier: CustomerNewsCVC.id)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

//    func reload(listNews: [NewCustomerHomeOptionalResponse]) {
//        self.data = listNews
//    }
}

extension HospitalNewsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomerNewsCVC.id, for: indexPath)
        (cell as? CustomerNewsCVC)?.bind(self.data[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
//        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.bounds.width - 50) / 1.2, height: collectionView.bounds.height / 2 - 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = data[indexPath.row]
        if let selectedD = self.selectedData {
            selectedD(selected)
        }
    }

//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let selected = data[indexPath.row]
//        if let selectedD = self.selectedData {
//            selectedD(selected)
//        }
//    }
}

class CustomerNewsCVC: UICollectionViewCell {
    static let id = "CustomerNewsCVC"

    private let imAvatar = UIImageView(image: UIImage(named: AssetsName.defaultImage))
    private let lbTitle = UILabel(text: "", font: .customOpenSans(16, .semiBold), color: AppColors.textBlack, breakable: true)
    private let lbContent = UILabel(text: "", font: .customOpenSans(12, .regular), color: AppColors.textBlack, breakable: true)
    private let lbUpdatetime = UILabel(text: "", font: .customOpenSans(12, .regular), color: UIColor(hex: "616066"), breakable: true)
    private var data: NewCustomerHomeOptionalResponse? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(_ data: NewCustomerHomeOptionalResponse) {
        self.data = data
        imAvatar.pictureSquareImageView(url: Common.stringToUrlImage(text: data.anhDaiDien ?? ""))
        if var tieuDe = data.tieuDe {
//            var spaceCount = 0
//            while tieuDe[spaceCount] != " " {
//                spaceCount += 1
//            }
//            tieuDe.removeLast(spaceCount)
            lbTitle.text = tieuDe
        }
        lbContent.text = data.moTa
        lbUpdatetime.text = data.ngayCapNhat
    }

    private func setupUI() {
        let vContainer = CardView()
        self.contentView.addSubview(vContainer)
        vContainer.layer.cornerRadius = 4
        vContainer.snp.makeConstraints({
            $0.top.leading.equalToSuperview().offset(4)
            $0.bottom.trailing.equalToSuperview().offset(-4)
        })
        vContainer.backgroundColor = .white
        vContainer.layer.cornerRadius = 8
        vContainer.clipsToBounds = true
//        vContainer.layer.borderWidth = 1
//        vContainer.layer.borderColor = AppColors.textBlue.cgColor
//        vContainer.clipsToBounds = true
        vContainer.addSubview(imAvatar)
        imAvatar.snp.makeConstraints({
            $0.centerY.leading.height.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.34)
        })
        imAvatar.clipsToBounds = true
        imAvatar.contentMode = .scaleAspectFill
        imAvatar.layer.cornerRadius = 8

        vContainer.addSubview(lbTitle)
        lbTitle.snp.makeConstraints({
            $0.leading.equalTo(imAvatar.snp.trailing).offset(4)
            $0.top.equalToSuperview().offset(4)
            $0.trailing.equalToSuperview().offset(-4)
        })
        lbTitle.numberOfLines = 2
        lbTitle.textAlignment = .left
//        lbContent.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)

        vContainer.addSubview(lbContent)
        lbContent.snp.makeConstraints({
            $0.centerX.width.equalTo(lbTitle)
            $0.top.equalTo(lbTitle.snp.bottom).offset(4)
        })

//        lbContent.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)

        vContainer.addSubview(lbUpdatetime)
        lbUpdatetime.snp.makeConstraints({
            $0.bottom.trailing.equalToSuperview().offset(-4)
            $0.top.greaterThanOrEqualTo(lbContent.snp.bottom).offset(4)
            $0.height.equalTo(18)
        })
//        lbUpdatetime.setContentHuggingPriority(UILayoutPriority(250), for: .vertical)
        
        vContainer.shadowColors = UIColor.gray
//        vContainer.dropShadow()
    }
}
