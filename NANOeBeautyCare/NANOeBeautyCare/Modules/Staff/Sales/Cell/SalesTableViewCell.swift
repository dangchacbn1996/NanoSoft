//
//  SalesTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/8/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class SalesTableViewCell:UITableViewCell, ReusableCell {
    typealias T = CellViewSales
    @IBOutlet weak var statusImageview: CircularImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sttLabel: UILabel!
    @IBOutlet weak var avartaImageview: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var discountOriginLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //Tất cả = -1, Tạo mới= 0, Còn nợ = 1,Đã thanh toán = 2, Hủy thanh thanh toán = 3
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
        } else if statusNumber == 6 {
            return (UIColor(hex: "EC1111"), UIImage(named: "ic-cancel"))
        }
        return (UIColor(hex: "9B9B9B"),  UIImage(named: "ic-cancel"))
    }

    var item: CellViewSales? {
        didSet {
            let model = item?.property?.model
            self.statusLabel.textColor = self.statusWithColor(statusNumber: model?.trangThai ?? -1).0
            self.statusImageview.image = self.statusWithColor(statusNumber: model?.trangThai ?? -1).1
            self.statusLabel.text = model?.trangThaiText
            self.titleLabel.text = model?.hoTen
            self.avartaImageview.avartaImageView(url: Common.stringToUrlImage(text: model?.anhKhachHang ?? ""))
            self.sttLabel.text = "#\(model?.idHoSo ?? 0)"
            self.timeLabel.text = model?.ngayCapNhat?.setStringToDate(formatCurrent: "dd/MM/yyyy HH:mm:ss")?.getFormattedDate(format: "HH:mm")
            self.priceLabel.text = model?.tongTien?.formatnumberWithCurrency()
            
            let orginMoney = model?.tongTienThanhToan ?? 0
            let disTotal = model?.giamGiaTong ?? 0

            if orginMoney > 0 && disTotal > 0 {
                self.discountOriginLabel.text = "(-\(disTotal.formatnumberWithCurrency()))"
                self.discountLabel.text = orginMoney.formatnumberWithCurrency()
            } else {
                self.discountOriginLabel.text = ""
                self.discountLabel.text = ""
            }
        }
    }

}
