//
//  AgencyCollectionViewCell.swift
//  NANOeBeautyCare
//
//  Created by Dom on 10/5/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class AgencyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var avartaImageview: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!

    func updateModel(model: AgencyCustomerHomeOptionalResponse) {
        self.titleLabel.text = model.tenPhongBan
        self.phoneLabel.text = "ĐT:\(model.soDienThoai ?? "")"
        self.addressLabel.text = model.diaChi ?? ""
        self.avartaImageview.pictureSquareImageView(url: Common.stringToUrlImage(text: model.logo ?? ""))

    }
}
