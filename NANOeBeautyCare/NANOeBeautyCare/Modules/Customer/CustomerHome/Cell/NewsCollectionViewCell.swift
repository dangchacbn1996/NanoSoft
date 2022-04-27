//
//  NewsCollectionViewCell.swift
//  NANOeBeautyCare
//
//  Created by Dom on 10/5/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var avartaImageview: UIImageView!
    @IBOutlet weak var descLabel: UILabel!

    func updateModel(model: NewCustomerHomeOptionalResponse) {
        self.categoryTitleLabel.text = model.tenNhomNews
        self.dateLabel.text = model.ngayCapNhat
        self.avartaImageview.pictureSquareImageView(url: Common.stringToUrlImage(text: model.anhDaiDien ?? ""))
        self.descLabel.text = model.tieuDe
    }
}
