//
//  CustomerDetailHistoryTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/22/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CustomerDetailHistoryTableViewCell: UITableViewCell, ReusableCell {
    private var lbTime = UILabel(font: UIFont.customNormal14, color: AppColors.textBlack)
    private var lbDesc = UILabel(font: UIFont.customOpenSans(14, .semiBold), color: AppColors.textBlue)
    private var lbPrice = UILabel(font: UIFont.customOpenSans(14, .semiBold), color: AppColors.textBlue)
    private var lbTotal = UILabel(font: UIFont.customOpenSans(14, .semiBold), color: AppColors.textBlue)
    private var lbDiscount = UILabel(font: UIFont.customOpenSans(14, .semiBold), color: AppColors.textBlue)

    var item: DefaultCellModel<CustomerDetailHistoryResponseElement>? {
        didSet {
            if let model = self.item?.property?.model {
                self.lbTime.text = model.ngayDen
                self.lbDesc.text = model.tenDichVuSanPhamThe
                self.lbPrice.text = model.tongTienThanhToan?.formatnumberWithCurrency()
                if let tong = model.tongTienThanhToan {
                    if let giamgia = model.giamGia {
                        self.lbPrice.text = (tong - Double(giamgia)).formatnumberWithCurrency()
                    }
                }
                self.lbDiscount.text = model.giamGia?.formatnumberWithCurrency()
                self.lbTotal.text = model.tongTienThanhToan?.formatnumberWithCurrency()
            }
        }
    }
    
    typealias T = DefaultCellModel<CustomerDetailHistoryResponseElement>
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupUI() {
        let vContainer = CardView()
        self.contentView.addSubview(vContainer)
        vContainer.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.size.equalToSuperview().offset(-16)
        })
        vContainer.backgroundColor = .white
        vContainer.layer.cornerRadius = 8
        let stack = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .fill, spacing: 6)
        vContainer.addSubview(stack)
        stack.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.size.equalToSuperview().offset(-16)
        })
        stack.addArrangedSubview(lbTime)
        stack.addArrangedSubview(lbDesc)
        stack.addArrangedSubview(UILabel(text: "Chi phí lần khám bệnh:", font: UIFont.customOpenSans(14, .semiBold), color: AppColors.textBlack))
        
        func addRow(title: String, for label: UILabel) {
            let row = UIView()
            let lbTitle = UILabel(text: title, font: UIFont.customNormal14, color: AppColors.textBlack)
            row.addSubview(lbTitle)
            lbTitle.snp.makeConstraints({
                $0.centerY.height.leading.equalToSuperview()
            })
            row.addSubview(label)
            label.snp.makeConstraints({
                $0.centerY.height.equalToSuperview()
                $0.leading.equalTo(lbTitle.snp.trailing).offset(8)
                $0.trailing.lessThanOrEqualToSuperview()
            })
            stack.addArrangedSubview(row)
        }
        addRow(title: "Tổng tiền:", for: lbPrice)
        addRow(title: "Giảm giá:", for: lbDiscount)
        addRow(title: "Thành tiền:", for: lbTotal)
    }

}
