//
//  NewsCustomTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Dom on 10/5/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class NewsCustomTableViewCell: UITableViewCell,ReusableCell {

    typealias T = CellViewCustomerHome
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    var data: CellDataCustomerHome?

    var selectedData: ((NewCustomerHomeOptionalResponse) -> Void)?
    
    var item: CellViewCustomerHome? {
        didSet {
            let model = item?.property?.model
            self.data = model
            self.titleLabel.text = "Tin tức"
        }
    }

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


}

extension NewsCustomTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let model = self.data {
            return model.newCustomer?.count ?? 0
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let model = self.data {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionViewCell", for: indexPath) as! NewsCollectionViewCell
            if let data = model.newCustomer?[indexPath.row]  {
                (cell as? NewsCollectionViewCell)?.updateModel(model: data)
            }
            return cell
        }
        return cell
    }


}

extension NewsCustomTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  30
        let collectionViewSize = collectionView.frame.size.height - 15
        let collectionViewSizeWidth = collectionView.frame.size.width - padding

        return CGSize(width: collectionViewSizeWidth, height: collectionViewSize/2)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let model = self.data {
            if let data = model.newCustomer?[indexPath.row]  {
                if let selectedD = self.selectedData {
                    selectedD(data)
                }
            }
        }
    }
}
