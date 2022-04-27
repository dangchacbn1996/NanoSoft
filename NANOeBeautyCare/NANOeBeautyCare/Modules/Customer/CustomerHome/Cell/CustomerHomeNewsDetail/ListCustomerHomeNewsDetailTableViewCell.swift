//
//  ListCustomerHomeNewsDetailTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Dom on 10/12/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class ListCustomerHomeNewsDetailTableViewCell: UITableViewCell,ReusableCell {
    typealias T = CellViewCustomerHomeNews

    var item: CellViewCustomerHomeNews? {
        didSet {
            let model = item?.property?.model
            self.titleLabel.text = model?.newsRe?.tieuDe
            self.dateLabel.text = model?.newsRe?.ngayCapNhat
            self.categoryLabel.text = model?.newsRe?.tenNhomNews
            self.avartaImageView.pictureSquareImageView(url: Common.stringToUrlImage(text: model?.newsRe?.anhDaiDien ?? ""))
        }
    }
    @IBOutlet weak var avartaImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    

}
