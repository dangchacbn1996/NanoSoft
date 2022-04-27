//
//  CustomerHomeNewsFilterTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Dom on 24/11/2020.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CustomerHomeNewsFilterTableViewCell: UITableViewCell,ReusableCell {
    typealias T = DefaultCellModel<NewCustomerHomeOptionalResponse>

    var item: DefaultCellModel<NewCustomerHomeOptionalResponse>? {
        didSet {
            let model = item?.property?.model
            self.titleLabel.text = model?.tieuDe
            self.dateLabel.text = model?.ngayCapNhat
            self.categoryLabel.text = model?.tenNhomNews
            self.avartaImageView.pictureSquareImageView(url: Common.stringToUrlImage(text: model?.anhDaiDien ?? ""))
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
