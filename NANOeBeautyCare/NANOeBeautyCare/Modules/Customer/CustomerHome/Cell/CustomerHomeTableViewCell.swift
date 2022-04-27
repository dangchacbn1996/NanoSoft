//
//  CustomerHomeTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/22/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CustomerHomeTableViewCell:UITableViewCell,ReusableCell {

    typealias T = DefaultCellModel<CustomerSocialOptionalResponse>
    @IBOutlet weak var cardViewOverlay: CardView!
    @IBOutlet weak var viewQuestion: CardView!
    @IBOutlet weak var avartaQuestion: UIImageView!
    @IBOutlet weak var dateQuestionLabel: UILabel!
    @IBOutlet weak var titleQuestionLabel: UILabel!

    @IBOutlet weak var viewAnswer: UIView!
    @IBOutlet weak var avartaAnswerImageView: UIImageView!
    @IBOutlet weak var titleAnswerLabel: UILabel!
    @IBOutlet weak var dateAnswerLabel: UILabel!
    @IBOutlet weak var descAnswerLabel: UILabel!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewAnswer.isHidden = true
        self.heightConstraint.constant = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var item: DefaultCellModel<CustomerSocialOptionalResponse>? {
        didSet {
            let model = item?.property?.model

            self.dateQuestionLabel.text = model?.ngayTao
            self.titleQuestionLabel.text = model?.noiDungCauHoi

            if model?.cauTraLoi?.count ?? 0 > 0 {
                self.cardViewOverlay.isHidden = false
                self.viewQuestion.resetCard()
                self.titleAnswerLabel.text = model?.cauTraLoi?.first?.bacSyTuVan
                self.dateAnswerLabel.text = model?.cauTraLoi?.first?.ngayTao
                self.descAnswerLabel.text = model?.cauTraLoi?.first?.noiDungTraLoi
                let heightLabel: CGFloat = heightForView(text: model?.cauTraLoi?.first?.noiDungTraLoi ?? "", font: UIFont.boldSystemFont(ofSize: 20.0), width: self.viewAnswer.frame.width)
                self.heightConstraint.constant = 117.0 + heightLabel
                self.viewAnswer.isHidden = false
            } else {
                self.viewQuestion.usingShadow()
                self.cardViewOverlay.isHidden = true
                self.viewAnswer.isHidden = true
                self.heightConstraint.constant = 0
            }
        }
    }

    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }
    

}
