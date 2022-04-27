//
//  SuggestionCollectionViewCell.swift
//  NANOeBeautyCare
//
//  Created by Dom on 10/5/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class SuggestionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var avartaImageview: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func updateModel(model: SuggestionCustomerHomeOptionalResponse) {
        self.titleLabel.text = model.tenDichVu
        self.avartaImageview.pictureSquareImageView(url: Common.stringToUrlImage(text: model.anhDichVu ?? ""))
    }    
}
