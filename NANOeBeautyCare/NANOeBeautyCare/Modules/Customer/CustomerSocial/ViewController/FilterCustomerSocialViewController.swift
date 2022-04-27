//
//  FilterCustomerSocialViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 23/11/2020
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class FilterCustomerSocialViewController: BaseViewController<FilterCustomerSocialPresenter> {
    // MARK: - IBOutlet
    
    @IBOutlet weak var collectionView: UICollectionView!

    var data: [ModelOptionResponseSocialCatalogDatum] = []
    var searchText: String = ""

    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = FilterCustomerSocialPresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Chọn danh mục"
        self.presenter?.initDataPresent()
        self.backButtonNavigation()
        self.data =  Common.socialCatalog
        self.collectionView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewFilterCustomerSocial) {

    }
    
    // MARK: - Action Button
    
}

// MARK: - Protocol of Presenter
extension FilterCustomerSocialViewController: FilterCustomerSocialVC {
    func initData(data: ViewFilterCustomerSocial) {
    }
    
    func reloadData() {
    }

    func resetData() {
        self.data =  Common.socialCatalog
        self.collectionView.reloadData()
    }

    func searchTextWithTitle(text: String) {
        self.data = Common.socialCatalog.filter({($0.tenNhomChuDe?.contains(text) ?? false)})
        self.collectionView.reloadData()
    }
}


extension FilterCustomerSocialViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
        (cell as? FilterCollectionViewCell)?.updateModel(model: self.data[indexPath.row])
        return cell
    }
}

extension FilterCustomerSocialViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //device screen size
        let width = self.collectionView.bounds.width
        //calculation of cell size
        return CGSize(width: ((width / 2) - 8), height: 56)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.backToPrevScreen(with: RouteContext([RVBackContext: self.data[indexPath.row]]))
    }
}

extension FilterCustomerSocialViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        searchActive = true;
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        searchActive = false;
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        self.resetData()
//        self.presenter?.originCustomerService()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchText = searchBar.text ?? ""
        self.searchTextWithTitle(text: self.searchText)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            self.searchText = ""
            // refresh data
            self.resetData()
        } else {
            self.searchText = searchBar.text ?? ""
            self.searchTextWithTitle(text: self.searchText)
        }
    }
}
