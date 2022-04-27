//
//  TextCustomerHomeNewsDetailTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Dom on 10/12/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit
import RichTextView

class TextCustomerHomeNewsDetailTableViewCell: UITableViewCell,ReusableCell {
    @IBOutlet weak var imageContentView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var htmlTextView: UITextView!
    @IBOutlet weak var htmlView: RichTextView!

    typealias T = CellViewCustomerHomeNews

    var item: CellViewCustomerHomeNews? {
        didSet {
            let model = item?.property?.model
            self.categoryLabel.text = model?.model?.tenNhomNews
            self.dateLabel.text = model?.model?.ngayCapNhat
            self.titleLabel.text = model?.model?.tieuDe
            self.imageContentView.pictureImageView(url: Common.stringToUrlImage(text: model?.model?.anhDaiDien ?? ""))
            let encodedData = (model?.model?.noiDung ?? "")
//                .replace(string: "\\\"", replacement: "\"")
//            print(encodedData)
//            self.htmlView.update(input: encodedData,
//                                 font: UIFont.systemFont(ofSize: 17.0))
            self.htmlTextView.htmlText = encodedData
            self.htmlTextView.adjustUITextViewHeight()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
