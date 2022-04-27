//
//  HomeCustomTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Dom on 10/5/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class HomeCustomTableViewCell: UITableViewCell,ReusableCell {

    typealias T = CellViewCustomerHome
    
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var data: CellDataCustomerHome?
    var selectedData: ((SuggestionCustomerHomeOptionalResponse) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var item: CellViewCustomerHome? {
        didSet {
            let model = item?.property?.model
            self.data = model
            self.titleLabel.text = "Bạn đang cần gì"
        }
    }
}

extension HomeCustomTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let model = self.data {
            return model.suggestionCustomer?.count ?? 0
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let model = self.data {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestionCollectionViewCell", for: indexPath) as! SuggestionCollectionViewCell
            if let data = model.suggestionCustomer?[indexPath.row]  {
                (cell as? SuggestionCollectionViewCell)?.updateModel(model: data)
            }
            return cell
        }
        return cell
    }
}

extension HomeCustomTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 160.0, height: collectionView.frame.size.height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let model = self.data {
            if let data = model.suggestionCustomer?[indexPath.row]  {
                if let selectedD = self.selectedData {
                    selectedD(data)
                }
            }
        }
    }
}
