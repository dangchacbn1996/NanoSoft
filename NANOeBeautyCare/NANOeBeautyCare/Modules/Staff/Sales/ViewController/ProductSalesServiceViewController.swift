//
//  ProductSalesServiceViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

enum EnumProductSales: Int {
    case Service = 0
    case Product = 1
    case Card = 2
}

protocol ProtocolProductSalesServiceViewController {
    func selectedModel(items: ViewProductSalesService)
}

class ProductSalesServiceViewController: BaseViewController<ProductSalesServicePresenter> {
    // MARK: - IBOutlet
    var delegate: ProtocolProductSalesServiceViewController?
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    var searchText = ""
    var isSearchActive = false
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pinterestLayout: PinterestLayout!
    var items: ViewProductSalesService?
    
    var serviceProductSearch: [ServiceProductOptionalResponse] = []
    var catalogProductSearch: [CatalogProductOptionalResponse] = []
    var cardProductSearch: [CardProductOptionalResponse] = []
    
    @IBOutlet weak var serviceButton: UIButton!
    @IBOutlet weak var productButton: UIButton!
    @IBOutlet weak var cardButton: UIButton!
    
    var isButtonSelect: EnumProductSales = .Service
    
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = ProductSalesServicePresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    func activeButton(button: UIButton) {
        button.backgroundColor = UIColor.white
        button.borderColor = .white
        button.borderWidth = 1.0
        button.setTitleColor(.black, for: .normal)
    }
    
    func deactiveButton(button: UIButton) {
        button.backgroundColor = UIColor.clear
        button.borderColor = .white
        button.borderWidth = 1.0
        button.setTitleColor(.white, for: .normal)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        pinterestLayout.delegate = self
        pinterestLayout.numberOfColumns = 2
        pinterestLayout.cellPadding = 6
        // Do any additional setup after loading the view.
        self.title = "Navigation.ProductSalesService".localized
        self.presenter?.initDataPresent()
        self.backButtonNavigation()
        
        let saveItem = UIBarButtonItem.button(image: UIImage(named: "ic-floppy-disk")!, title: "", target: self, action: #selector(self.actionSave))
        self.navigationItem.rightBarButtonItems = [saveItem]
        
        let gradient = CAGradientLayer()
        let bounds = self.view.bounds
        gradient.frame = bounds
        gradient.colors = [AppColors.gradientStart.cgColor, AppColors.gradientMid.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        
        if let image = getImageFrom(gradientLayer: gradient) {
            self.backgroundView.backgroundColor = UIColor(patternImage: image)
        }
        
        //        let layout = CollectionViewWaterfallLayout()
        //        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        //        layout.headerInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        //        layout.headerHeight = 50
        //        layout.footerHeight = 20
        //        layout.minimumColumnSpacing = 10
        //        layout.minimumInteritemSpacing = 10
        //
        //        collectionView.collectionViewLayout = layout
        //        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: CollectionViewWaterfallElementKindSectionHeader, withReuseIdentifier: "Header")
        //        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: CollectionViewWaterfallElementKindSectionFooter, withReuseIdentifier: "Footer")
        
        self.activeButton(button: self.serviceButton)
        self.deactiveButton(button: self.productButton)
        self.deactiveButton(button: self.cardButton)
        self.searchBar.delegate = self
    }
    
    @objc func actionSave() {
        self.hideKeyboard()
        if let modelCom = self.items {
            let cardProduct = modelCom.cardProduct?.filter({ (item) -> Bool in
                return item.isSelected == true
            })
            let serviceProduct = modelCom.serviceProduct?.filter({ (item) -> Bool in
                return item.isSelected == true
            })
            let catalogProduct = modelCom.catalogProduct?.filter({ (item) -> Bool in
                return item.isSelected == true
            })
            let modelSelected = ViewProductSalesService(serviceProduct: serviceProduct, catalogProduct: catalogProduct, cardProduct: cardProduct)
            self.delegate?.selectedModel(items: modelSelected)
            self.backToPrevScreen(with: RouteContext([RVBackContext:modelSelected]))
        }
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewProductSalesService) {
        
    }
    
    // MARK: - Action Button
    @IBAction func serviceButtonAction(_ sender: Any) {
        isSearchActive = false
        searchBar.text = ""
        searchText = ""
        isButtonSelect = .Service
        self.reloadData()
        self.activeButton(button: self.serviceButton)
        self.deactiveButton(button: self.productButton)
        self.deactiveButton(button: self.cardButton)
        
    }
    
    @IBAction func productButtonAction(_ sender: Any) {
        isSearchActive = false
        searchBar.text = ""
        searchText = ""
        isButtonSelect = .Product
        self.reloadData()
        self.activeButton(button: self.productButton)
        self.deactiveButton(button: self.serviceButton)
        self.deactiveButton(button: self.cardButton)
    }
    @IBAction func cardButtonAction(_ sender: Any) {
        isSearchActive = false
        searchBar.text = ""
        searchText = ""
        isButtonSelect = .Card
        self.reloadData()
        self.activeButton(button: self.cardButton)
        self.deactiveButton(button: self.serviceButton)
        self.deactiveButton(button: self.productButton)
    }
    
    func resetData() {
        self.isSearchActive = false
        self.collectionView.reloadData()
    }
    
}

// MARK: - Protocol of Presenter
extension ProductSalesServiceViewController: ProductSalesServiceVC {
    func initData(data: ViewProductSalesService) {
        self.items = data
        if let model = self.items?.cardProduct {
            self.cardProductSearch = model
        }
        if let model = self.items?.catalogProduct {
            self.catalogProductSearch = model
        }
        
        if let model = self.items?.serviceProduct {
            self.serviceProductSearch = model
        }
    }
    
    func reloadData() {
        self.collectionView.reloadData()
        self.collectionView.setContentOffset(.zero, animated: false)
    }
    
    func updateCheckStatus(idSP: Int?, indexPath: IndexPath, data: CheckProductOptionalResponse?) {
        
        if self.isSearchActive == false {
            if let isSelected = self.items?.catalogProduct?[indexPath.row].isSelected {
                self.items?.catalogProduct?[indexPath.row].soLuongTonMin = data?.soLuongTonMin ?? -1
                self.items?.catalogProduct?[indexPath.row].tenDonViMin = data?.tenDonViMin ?? ""
//                if (data?.soLuongTonMin ?? -1) > 0 {
                    self.items?.catalogProduct?[indexPath.row].isSelected = !isSelected
//                }
            }
            self.collectionView.reloadItems(at: [indexPath])
        } else {
            catalogProductSearch[indexPath.row].soLuongTonMin = data?.soLuongTonMin ?? -1
            catalogProductSearch[indexPath.row].tenDonViMin = data?.tenDonViMin ?? ""
            
//            if (data?.soLuongTonMin ?? -1) >= 0 {
                let isSelected = self.catalogProductSearch[indexPath.row].isSelected
                catalogProductSearch[indexPath.row].isSelected = !isSelected
                let productss = self.items?.catalogProduct ?? []
                for (key,item) in productss.enumerated() {
                    let idTheDicVu = item.id ?? -1
                    let isSelectedId = self.catalogProductSearch[indexPath.row].id ?? -2
                    if idTheDicVu == isSelectedId {
                        if let isSelected = self.items?.catalogProduct?[indexPath.row].isSelected {
                            self.items?.catalogProduct?[key].isSelected = !isSelected
                        }
                        break
                    } else {
                        continue
                    }
                }
//            }
            self.collectionView.reloadItems(at: [indexPath])
        }
    }
}




// MARK: - UICollectionViewDataSource
extension ProductSalesServiceViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.isSearchActive == false {
            switch self.isButtonSelect {
            case .Card:
                return items?.cardProduct?.count ?? 0
            case .Product:
                return items?.catalogProduct?.count ?? 0
            default:
                return items?.serviceProduct?.count ?? 0
            }
        } else {
            switch self.isButtonSelect {
            case .Card:
                return self.cardProductSearch.count
            case .Product:
                return self.catalogProductSearch.count
            default:
                return self.serviceProductSearch.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductSalesCollectionViewCell", for: indexPath) as! ProductSalesCollectionViewCell
        
        if self.isSearchActive == false {
            
            switch self.isButtonSelect {
            case .Card:
                if let model = self.items?.cardProduct?[indexPath.row] {
                    cell.updateCardCell(model: model)
                }
            case .Product:
                if let model = self.items?.catalogProduct?[indexPath.row] {
                    cell.updateCatalogCell(model: model)
                }
            default:
                if let model = self.items?.serviceProduct?[indexPath.row] {
                    cell.updateServiceCell(model: model)
                }
            }
        } else {
            switch self.isButtonSelect {
            case .Card:
                let model = self.cardProductSearch[indexPath.row]
                cell.updateCardCell(model: model)
            case .Product:
                let model = self.catalogProductSearch[indexPath.row]
                cell.updateCatalogCell(model: model)
            default:
                let model = self.serviceProductSearch[indexPath.row]
                cell.updateServiceCell(model: model)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.isSearchActive == false {
            switch self.isButtonSelect {
            case .Card:
                if let isSelected = self.items?.cardProduct?[indexPath.row].isSelected {
                    self.items?.cardProduct?[indexPath.row].isSelected = !isSelected
                }
            case .Product:
                let idSp = self.items?.catalogProduct?[indexPath.row].id
                self.presenter?.serviceCheckProduct(idSP: idSp, index: indexPath)
            default:
                if let isSelected = self.items?.serviceProduct?[indexPath.row].isSelected {
                    self.items?.serviceProduct?[indexPath.row].isSelected = !isSelected
                }
            }
            
            self.collectionView.reloadItems(at: [indexPath])
        } else {
            switch self.isButtonSelect {
            case .Card:
                let isSelected = self.cardProductSearch[indexPath.row].isSelected
                self.cardProductSearch[indexPath.row].isSelected = !isSelected
                
                let productss = self.items?.cardProduct ?? []
                for (key,item) in productss.enumerated() {
                    let idTheDicVu = item.idTheDichVu ?? -1
                    let isSelectedId = self.cardProductSearch[indexPath.row].idTheDichVu ?? -2
                    if idTheDicVu == isSelectedId {
                        if let isSelected = self.items?.cardProduct?[indexPath.row].isSelected {
                            self.items?.cardProduct?[key].isSelected = !isSelected
                        }
                        break
                    } else {
                        continue
                    }
                }
            case .Product:
                let idSp = self.catalogProductSearch[indexPath.row].id
                self.presenter?.serviceCheckProduct(idSP: idSp, index: indexPath)
            default:
                let isSelected = self.serviceProductSearch[indexPath.row].isSelected
                serviceProductSearch[indexPath.row].isSelected = !isSelected
                
                let productss = self.items?.serviceProduct ?? []
                for (key,item) in productss.enumerated() {
                    let idTheDicVu = item.idDichVu ?? -1
                    let isSelectedId = self.serviceProductSearch[indexPath.row].idDichVu ?? -2
                    if idTheDicVu == isSelectedId {
                        if let isSelected = self.items?.serviceProduct?[indexPath.row].isSelected {
                            self.items?.serviceProduct?[key].isSelected = !isSelected
                        }
                        break
                    } else {
                        continue
                    }
                }
            }
            self.collectionView.reloadItems(at: [indexPath])
        }
    }
}

//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let reusableView: UICollectionReusableView?
//
//        switch kind {
//        case CollectionViewWaterfallElementKindSectionHeader:
//            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
//            header.backgroundColor = .red
//            reusableView = header
//        case CollectionViewWaterfallElementKindSectionFooter:
//            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath)
//            footer.backgroundColor = .blue
//            reusableView = footer
//        default:
//            reusableView = nil
//        }
//
//        return reusableView!
//    }

extension ProductSalesServiceViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        self.isSearchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        self.resetData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        self.resetData()
        //        self.defaultNavigation()
        //        self.presenter?.originCustomerService()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        self.resetData()
        //        self.defaultNavigation()
//        self.searchText = searchBar.text ?? ""
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            self.searchText = ""
            // refresh data
            self.resetData()
        } else {
            //tenDichVu
            self.resetData()
            self.isSearchActive = true
            self.searchText = (searchBar.text ?? "").lowercased()
            
            switch self.isButtonSelect {
            case .Card:
                if let model = self.items?.cardProduct {
                    self.cardProductSearch = model
                    self.cardProductSearch = model.filter { (models) -> Bool in
                        return (models.tenLoaiTheDichVu ?? "").slugify().range(of: searchText.slugify(), options: .caseInsensitive) != nil
                    }
                }
            case .Product:
                if let model = self.items?.catalogProduct {
                    self.catalogProductSearch = model
                    self.catalogProductSearch = model.filter { (models) -> Bool in
                        return (models.tenSanPham ?? "").slugify().range(of: searchText.slugify(), options: .caseInsensitive) != nil
                    }
                }
            default:
                if let model = self.items?.serviceProduct {
                    self.serviceProductSearch = model
                    self.serviceProductSearch = model.filter { (models) -> Bool in
                        return (models.tenDichVu ?? "").slugify().range(of: searchText.slugify(), options: .caseInsensitive) != nil
                    }
                }
            }
            self.collectionView.reloadData()
        }
    }
}


// WaterflowViewDelegate
extension ProductSalesServiceViewController: PinterestLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout: PinterestLayout, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat {
        var labelHeight: CGFloat = 0
        if self.isSearchActive == false {
            switch self.isButtonSelect {
            case .Card:
                if let model = self.items?.cardProduct?[indexPath.row] {
                    let text = model.tenLoaiTheDichVu
                    labelHeight = text?.heightFitting(width: layout.cellWidth, font: .boldSystemFont(ofSize: 25.0)) ?? 0.0
                }
            case .Product:
                if let model = self.items?.catalogProduct?[indexPath.row] {
                    let text = model.tenSanPham
                    labelHeight = text?.heightFitting(width: layout.cellWidth, font: .boldSystemFont(ofSize:  25.0)) ?? 0.0
                }
            default:
                if let model = self.items?.serviceProduct?[indexPath.row] {
                    let text = model.tenDichVu
                    labelHeight = text?.heightFitting(width: layout.cellWidth, font: .boldSystemFont(ofSize:  25.0)) ?? 0.0
                }
            }
        } else {
            switch self.isButtonSelect {
            case .Card:
                let model = self.cardProductSearch[indexPath.row]
                let text = model.tenLoaiTheDichVu
                labelHeight = text?.heightFitting(width: layout.cellWidth, font: .boldSystemFont(ofSize:  25.0)) ?? 0.0
            case .Product:
                let model = self.catalogProductSearch[indexPath.row]
                let text = model.tenSanPham
                labelHeight = text?.heightFitting(width: layout.cellWidth, font: .boldSystemFont(ofSize:  25.0)) ?? 0.0
            default:
                let model = self.serviceProductSearch[indexPath.row]
                let text = model.tenDichVu
                labelHeight = text?.heightFitting(width: layout.cellWidth, font: .boldSystemFont(ofSize:  25.0)) ?? 0.0
            }
        }
        
        let image:CGFloat = 200.0
        let scaledImageHeight:CGFloat = ((image * layout.cellWidth) / image) + 65.0
        let padding:CGFloat = 8
        
        return scaledImageHeight + padding + labelHeight
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: PinterestLayout, heightForBannerAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 15
    }
    
    func numberOfItemsBeforeAds(in collectionView: UICollectionView) -> Int {
        return 10
    }
    

}

extension String {
    func heightFitting(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [.font: font], context: nil)
        return boundingBox.height
    }
}
