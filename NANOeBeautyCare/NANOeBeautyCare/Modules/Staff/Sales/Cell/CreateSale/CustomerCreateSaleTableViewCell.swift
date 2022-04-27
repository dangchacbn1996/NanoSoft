//
//  CustomerCreateSaleTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/30/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CustomerCreateSaleTableViewCell: UITableViewCell, ReusableCell {

    typealias T = CellViewCreateSale

    var item: CellViewCreateSale? {
        didSet {
            let model = item?.property?.model?.customer
//            self.statusImageview.avartaImageView(url: Common.stringToUrlImage(text: <#T##String#>))
            self.titleLabel.text = model?.hoTen
            self.dateLabel.text = model?.ngayDen.setStringToDate(formatCurrent: "dd/MM/yyyy HH:mm:ss")?.getFormattedDate(format: "dd/MM/yyyy HH:mm:ss")
            self.codeLabel.text = model?.maHoSo

            let status = model?.trangThaiSwipe ?? 0
            self.statusLabel.textColor = self.statusWithColor(statusNumber: status).0
            self.statusImageview.image = self.statusWithColor(statusNumber: status).1
            self.statusLabel.text = model?.trangThaiSwipeText
            
            self.avaratCustomer.avartaImageView(url: Common.stringToUrlImage(text: model?.anhKhachHang ?? ""))
            if status == 0 {
                self.addListService.isHidden = false
            } else {
                self.addListService.isHidden = true
            }
        }
    }

    @IBOutlet weak var avaratCustomer: UIImageView!
    @IBOutlet weak var statusImageview: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var avartaImageview: UIImageView!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var addListService: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    Tất cả = -1, Tạo mới= 0, Còn nợ = 1,Đã thanh toán = 2, Hủy thanh thanh toán = 3
    func statusWithColor(statusNumber: Int) -> (UIColor, UIImage?){
        if statusNumber == 0 {
            return (UIColor(hex: "9B9B9B"),  UIImage(named: "ic-new"))
        } else if statusNumber == 1 {
            return (UIColor(hex: "F87F28"),  UIImage(named: "ic-wait"))
        } else if statusNumber == 2 {
            return (UIColor(hex: "F87F28"),  UIImage(named: "ic-wait"))
        } else if statusNumber == 3 {
            return (UIColor(hex: "EC1111"), UIImage(named: "ic-cancel"))
        } else if statusNumber == 4 {
            return (UIColor(hex: "4E94E4"),  UIImage(named: "ic-progerss"))
        } else if statusNumber == 5 {
            return (AppColors.primaryColor,  UIImage(named: "ic-success"))
        }
        return (UIColor(hex: "9B9B9B"),  UIImage(named: "ic-cancel"))
    }
}
