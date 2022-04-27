//
//  CustomFormViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/6/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

enum EnumCustomForm: Int {
    case ContentOnly = 0
    case Member = 1
    case Services = 2
}

class CustomFormViewController: SwiftPopup {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerXIB(CustomFormTableViewCell.identfier)
            tableView.registerXIB(ServiceCustomFormTableViewCell.identfier)
            tableView.registerXIB(MemberCustomFormTableViewCell.identfier)
        }
    }

    @IBOutlet weak var cancelButton: UIButton!
    var searchText: String = ""
    var isSearchActive: Bool = false
    var isTypeCell:EnumCustomForm = .ContentOnly
    var items: [CustomFormModelElement] = []
    var itemsSearch: [CustomFormModelElement] = []

    var dataSource:TableDataSource<DefaultHeaderFooterModel<CustomFormModelElement>,
    DefaultCellModel<CustomFormModelElement>,
    CustomFormModelElement>?

    var selected: ((_ indexPath : IndexPath, _ item: CustomFormModelElement?) -> Void)?
    var selectedArray: ((_ item: [CustomFormModelElement]?) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureTableView()

        switch self.isTypeCell {
        case .Services:
            self.saveButton.isHidden = false
        case .Member:
            self.saveButton.isHidden = false
        default:
            self.saveButton.isHidden = true
        }

        self.dataSource?.stopInfiniteLoading(.FinishLoading)
        self.searchBar.delegate = self
    }

    private func configureTableView() {
        switch isTypeCell {
        case .Services:
            dataSource = TableDataSource<DefaultHeaderFooterModel<CustomFormModelElement>, DefaultCellModel<CustomFormModelElement>, CustomFormModelElement>.init(.SingleListing(items: (isSearchActive == false) ? self.items: self.itemsSearch, identifier: ServiceCustomFormTableViewCell.identfier, height: UITableView.automaticDimension, leadingSwipe: nil, trailingSwipe: nil), tableView)
        case .Member:
            dataSource = TableDataSource<DefaultHeaderFooterModel<CustomFormModelElement>, DefaultCellModel<CustomFormModelElement>, CustomFormModelElement>.init(.SingleListing(items: (isSearchActive == false) ? self.items: self.itemsSearch, identifier: MemberCustomFormTableViewCell.identfier, height: UITableView.automaticDimension, leadingSwipe: nil, trailingSwipe: nil), tableView)
        default:
            dataSource = TableDataSource<DefaultHeaderFooterModel<CustomFormModelElement>, DefaultCellModel<CustomFormModelElement>, CustomFormModelElement>.init(.SingleListing(items: (isSearchActive == false) ? self.items: self.itemsSearch, identifier: CustomFormTableViewCell.identfier, height: UITableView.automaticDimension, leadingSwipe: nil, trailingSwipe: nil), tableView)
        }

        dataSource?.configureCell = { (cell, item, indexPath) in
            switch self.isTypeCell {
            case .Services:
                (cell as? ServiceCustomFormTableViewCell)?.item = item
            case .Member:
                (cell as? MemberCustomFormTableViewCell)?.item = item
            default:
                (cell as? CustomFormTableViewCell)?.item = item
            }
        }

        dataSource?.didSelectRow = { (indexPath, item) in
            switch self.isTypeCell {
            case .Services:
                if self.isSearchActive == false {
                    self.items[indexPath.row].isSelected = !self.items[indexPath.row].isSelected
                    self.dataSource?.updateAndReload(for: .SingleListing(items: self.items), .Reload(indexPaths: [indexPath], animation: .fade))
                } else {
                    self.itemsSearch[indexPath.row].isSelected = !self.itemsSearch[indexPath.row].isSelected
                    self.dataSource?.updateAndReload(for: .SingleListing(items: self.itemsSearch), .Reload(indexPaths: [indexPath], animation: .fade))
                }
            case .Member:
                if self.isSearchActive == false {
                    self.items[indexPath.row].isSelected = !self.items[indexPath.row].isSelected
                    self.dataSource?.updateAndReload(for: .SingleListing(items: self.items), .Reload(indexPaths: [indexPath], animation: .fade))
                } else {
                    self.itemsSearch[indexPath.row].isSelected = !self.itemsSearch[indexPath.row].isSelected
                    self.dataSource?.updateAndReload(for: .SingleListing(items: self.itemsSearch), .Reload(indexPaths: [indexPath], animation: .fade))
                }
            default:
                guard let sele = self.selected else {
                    return
                }
                if self.isSearchActive == false {
                    sele(indexPath, item?.property?.model)
                } else {
                    sele(indexPath, item?.property?.model)
                }
                self.dismiss()
            }
        }

    }


    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func saveButtonAction(_ sender: Any) {
        switch self.isTypeCell {
        case .Services:
            guard let sele = self.selectedArray else {
                return
            }
            if self.isSearchActive == false {
                sele(self.items)
            } else {
                sele(self.itemsSearch)
            }
            self.dismiss()
        case .Member:
            guard let sele = self.selectedArray else {
                return
            }
            if self.isSearchActive == false {
                sele(self.items)
            } else {
                sele(self.itemsSearch)
            }
            self.dismiss()
        default:
            self.dismiss()
        }
    }
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.dismiss()
    }
    
    func resetData() {
        self.isSearchActive = false
        self.itemsSearch.removeAll()
        self.dataSource?.updateAndReload(for: .SingleListing(items: self.items), .FullReload)
    }
}

extension CustomFormViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.isSearchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.resetData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.resetData()
//        self.defaultNavigation()
//        self.presenter?.originCustomerService()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.resetData()
//        self.defaultNavigation()
        self.searchText = searchBar.text ?? ""
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            self.searchText = ""
            // refresh data
            self.resetData()
        } else {
            //tenDichVu
            self.resetData()
            self.searchText = (searchBar.text ?? "").lowercased()
            self.itemsSearch = self.items.filter { (models) -> Bool in
                switch self.isTypeCell {
                case .Services:
                    guard let model = models.rawItem as? ModelOptionResponseServiceCatalogDatum else {
                        return false
                    }
                    guard let tenDichVu = model.tenDichVu?.lowercased() else {
                        return false
                    }
                    return tenDichVu.slugify().range(of: searchText.slugify(), options: .caseInsensitive) != nil
                case .Member:
                    guard let model = models.rawItem as? ModelOptionResponseEmployeeAndSearchCatalogDatum else {
                        return false
                    }
                    guard let tennhanvien = model.tenNhanVien?.lowercased() else {
                        return false
                    }
                    return tennhanvien.slugify().range(of: searchText.slugify(), options: .caseInsensitive) != nil
                    
                default:
                    guard let title = models.selected?.lowercased() else {
                        return false
                    }
                    return title.slugify().range(of: searchText.slugify(), options: .caseInsensitive) != nil
                }
            }
            self.isSearchActive = true
            self.dataSource?.updateAndReload(for: .SingleListing(items: self.itemsSearch), .FullReload)
        }
    }
}

extension CustomFormViewController {
    /// sets data in datasource
    public func setData(data: [CustomFormModelElement]) {
        self.items = data
    }
}
