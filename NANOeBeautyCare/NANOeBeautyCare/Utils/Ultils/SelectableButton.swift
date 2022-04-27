//
//  SelectableButton.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 22/05/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

class SelectableButton: UIButton {
    let vChecked = UIImageView(image: UIImage(named: "ic-check-circle")?.withRenderingMode(.alwaysTemplate))
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
////        self.addChecked()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func addChecked() {
        self.addSubview(vChecked)
        vChecked.snp.makeConstraints({
            $0.leading.equalToSuperview().offset(self.layer.cornerRadius == 0 ? 8 : self.layer.cornerRadius)
            $0.centerY.equalToSuperview()
            if self.bounds.height < 48 {
                $0.size.equalTo(self.snp.height).multipliedBy(0.4)
            } else {
                $0.size.equalTo(32)
            }
        })
        vChecked.contentMode = .scaleAspectFit
        vChecked.tintColor = .white
        vChecked.isHidden = true
        self.titleLabel?.snp.makeConstraints({
            $0.trailing.equalToSuperview().offset(self.layer.cornerRadius == 0 ? -4 : -self.layer.cornerRadius)
            $0.leading.equalTo(vChecked.snp.trailing).offset(2)
        })
        titleLabel?.textAlignment = .center
    }
    
    func setChecked(_ isChecked: Bool) {
        vChecked.tintColor = self.titleLabel?.textColor ?? .white
        self.isSelected = isChecked
        vChecked.isHidden = !isSelected
    }
    
}
