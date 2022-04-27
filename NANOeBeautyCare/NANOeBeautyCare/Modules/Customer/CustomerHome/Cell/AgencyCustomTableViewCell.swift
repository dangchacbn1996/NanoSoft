//
//  AgencyCustomTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Dom on 10/5/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class AgencyCustomTableViewCell: UITableViewCell,ReusableCell {

    typealias T = CellViewCustomerHome
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var data: CellDataCustomerHome?

    var selectedData: ((AgencyCustomerHomeOptionalResponse) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.dataSource = self
        collectionView.delegate = self

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var item: CellViewCustomerHome? {
        didSet {
            let model = item?.property?.model
            self.data = model
            self.titleLabel.text = "Thông tin cơ sở"
        }
    }
}

extension AgencyCustomTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let model = self.data {
                return model.agencyCustomer?.count ?? 0
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let model = self.data {
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgencyCollectionViewCell", for: indexPath) as! AgencyCollectionViewCell
                if let data = model.agencyCustomer?[indexPath.row]  {
                    (cell as? AgencyCollectionViewCell)?.updateModel(model: data)
                }
                return cell
        }
        return cell
    }


}

extension AgencyCustomTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  30
        let collectionViewSize = collectionView.frame.size.height - padding
        let collectionViewSizeWidth = collectionView.frame.size.width - padding

        return CGSize(width: collectionViewSizeWidth, height: collectionViewSize)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let model = self.data {
            Common.callNumber(phoneNumber: model.agencyCustomer?[indexPath.row].soDienThoai ?? "")
        }
    }
}
