//
//  FilterCollectionViewCell.swift
//  NANOeBeautyCare
//
//  Created by Dom on 24/11/2020.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!


    func updateModel(model: ModelOptionResponseSocialCatalogDatum) {
        self.titleLabel.text = model.tenNhomChuDe
        titleLabel.numberOfLines = 0
    }

}
