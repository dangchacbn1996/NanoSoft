//
//  ExamListTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 05/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

class ExamListTableViewCell: UITableViewCell, ReusableCell {
    var item: CellViewCustomerHome? {
        didSet {
//            let model = item?.property?.model
            lbName.text = "Bạn đang cần gì"
//            self.data = model
//            self.titleLabel.text = "Bạn đang cần gì"
        }
    }
    
    static let id = "ExamListTableViewCell"
    
    typealias T = CellViewCustomerHome
    
    private let vContainer = UIView()
    private let ivAvatar = UIImageView()
    private let lbName = UILabel(font: UIFont.systemFont(ofSize: 14, weight: .semibold), color: .black)
    private let lbPhone = UILabel(font: UIFont.systemFont(ofSize: 14), color: .black)
    private let lbContent = UILabel(font: UIFont.systemFont(ofSize: 12), color: .black, breakable: true)
    private let lbCount = UILabel(font: UIFont.systemFont(ofSize: 12), color: .yellow)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc private func actMore(_ tapGes: UITapGestureRecognizer) {
        
    }
    
    private func setupUI() {
        self.addSubview(vContainer)
        vContainer.snp.makeConstraints({
            $0.top.equalToSuperview().offset(4)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-8)
        })
        vContainer.shadow()
        vContainer.addSubview(ivAvatar)
        ivAvatar.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.size.equalTo(vContainer.snp.height).multipliedBy(0.6)
            $0.leading.equalToSuperview().offset(8)
        })
        vContainer.addSubview(lbName)
        lbName.snp.makeConstraints({
            $0.top.equalToSuperview().offset(4)
            $0.leading.equalTo(ivAvatar.snp.trailing).offset(8)
        })
        vContainer.addSubview(lbPhone)
        lbPhone.snp.makeConstraints({
            $0.centerX.width.equalTo(lbName)
            $0.top.equalTo(lbName.snp.bottom).offset(6)
        })
        vContainer.addSubview(lbContent)
        lbContent.snp.makeConstraints({
            $0.centerX.width.equalTo(lbName)
            $0.top.equalTo(lbPhone.snp.bottom).offset(6)
            $0.bottom.lessThanOrEqualToSuperview().offset(-4)
        })
        lbContent.numberOfLines = 0
        
        let lbMore = UIButton()
        vContainer.addSubview(lbMore)
        lbMore.snp.makeConstraints({
            $0.top.trailing.equalToSuperview()
            $0.size.equalTo(36)
            $0.leading.equalTo(lbName.snp.trailing).offset(8)
        })
        lbMore.imageView?.contentMode = .scaleAspectFit
        lbMore.setImage(UIImage(named: "ic-more")?.withRenderingMode(.alwaysTemplate), for: .normal)
        lbMore.imageView?.transform = CGAffineTransform(rotationAngle: .pi / 2)
        lbMore.imageView?.tintColor = .gray
        lbMore.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.actMore(_:))))
        
        vContainer.addSubview(lbCount)
        lbCount.snp.makeConstraints({
            $0.bottom.trailing.equalToSuperview().offset(-8)
        })
    }
}
