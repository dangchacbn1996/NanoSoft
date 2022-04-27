//
//  CreateSaleServiceViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/30/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CreateSaleServiceViewController: BaseViewController<CreateSaleServicePresenter> {
    // MARK: - IBOutlet
    @IBOutlet weak var viewListSearchBar: CardView!
    @IBOutlet weak var tableViewSearch: UITableView! {
           didSet {
               tableViewSearch.registerXIB(SearchCustomerTableViewCell.identfier)
           }
       }
    var itemSearch: [CustomFormModelElement] = []
    var dataSourceSearch: TableDataSource<DefaultHeaderFooterModel<CustomFormModelElement>,
    DefaultCellModel<CustomFormModelElement>,
    CustomFormModelElement>?

    private var searchActive = false

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    

    var items: [ViewCreateSale] = []
    private var dataSource: TableDataSource<ViewCreateSale, CellViewCreateSale, ViewCreateSaleService>?
    
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = CreateSaleServicePresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Navigation.CreateSaleService".localized
        self.presenter?.initDataPresent()
        self.configureTableView()
        self.configureTableViewSearch()
        self.backButtonNavigation()
       

    }

    // MARK: - Action Button
    @objc func actionSave() {
        self.hideKeyboard()
        self.presenter?.services()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.presenter?.checkContextUpdate()
    }

    override func updatePanData(context: RouteContext) {
        super.updatePanData(context: context)
//        print(context[RVBackContext])
        self.presenter?.updateBackContextData(context: context)
    }

    private func configureTableView() {
        dataSource = TableDataSource<ViewCreateSale, CellViewCreateSale, ViewCreateSaleService>.init(.MultipleSection(items: self.items), tableView)


        dataSource?.configureCell = { (cell, item, indexPath) in
            if self.items.count == 2 {
                if item?.property?.model?.customer != nil {
                    if indexPath.section == 0 {
                        (cell as? CustomerCreateSaleTableViewCell)?.item = item
                        (cell as? CustomerCreateSaleTableViewCell)?.addListService.addAction(for: .touchUpInside, closure: { (button) in
                            self.presenter?.addListService()
                        })
                    } else {
                        (cell as? FooterCreateSaleTableViewCell)?.item = item
                    }
                } else {
                    if indexPath.section == 0 {
                        (cell as? HeaderCreateSaleTableViewCell)?.item = item
                        (cell as? HeaderCreateSaleTableViewCell)?.addServiceButton.addAction(for: .touchUpInside, closure: { (button) in
                            self.presenter?.addListService()
                        })
                    } else {
                        (cell as? FooterCreateSaleTableViewCell)?.item = item
                    }
                }
            } else {
                switch indexPath.section {
                case CreateSaleTableSectionEnum.Header.rawValue:
                    (cell as? CustomerCreateSaleTableViewCell)?.item = item
                    (cell as? CustomerCreateSaleTableViewCell)?.addListService.addAction(for: .touchUpInside, closure: { (button) in
                        self.presenter?.addListService()
                    })
                case CreateSaleTableSectionEnum.Body.rawValue:
                    if let itemService = item?.property?.model?.listService {
                        if itemService.trangthaiSwipe == 0 {
                            self.searchBar.isHidden = false
                            var editAction = SwipeableCellAction(title: nil, image: UIImage(named: "edit-icon"), backgroundColor: UIColor(hex: "6aadfa")) {
                                print("Edit")
                                    self.presenter?.openEditer(item: itemService)
                            }

                            var deleteAction = SwipeableCellAction(title: nil, image: UIImage(named: "delete-icon"), backgroundColor: UIColor(hex: "F16C7C")) {
                                print("Delete")
                                self.presenter?.deleteProduct(index: indexPath.row)
                            }
                            editAction.width = 100
                            editAction.verticalSpace = 6
                            deleteAction.width = 100
                            deleteAction.verticalSpace = 6
                            (cell as? ListServiceCreateSaleTableViewCell)?.actions = [deleteAction, editAction]
                        } else {
                            self.searchBar.isHidden = true
                        }
                    }
                    (cell as? ListServiceCreateSaleTableViewCell)?.item = item

                case CreateSaleTableSectionEnum.Footer.rawValue:
                    (cell as? FooterCreateSaleTableViewCell)?.item = item
                    (cell as? FooterCreateSaleTableViewCell)?.discountInvoteButton.addAction(for: .touchUpInside, closure: { (button) in
                        self.presenter?.addInvoteService()
                    })
                    (cell as? FooterCreateSaleTableViewCell)?.cancelPaymentButton.addAction(for: .touchUpInside, closure: { (button) in
                        self.alertTwoActionButton(cancelAction: "Huỷ", description: "Bạn chắc chắn muốn xoá thanh toán đơn hàng này?", titleAction: "Đồng ý") {
                            self.presenter?.cancelPayment()
                        } actionCancel: {

                        }

                    })
                    (cell as? FooterCreateSaleTableViewCell)?.confirmPaymentButton.addAction(for: .touchUpInside, closure: { (button) in
                        self.alertTwoActionButton(cancelAction: "Huỷ", description: "Bạn chắc chắn muốn xác nhận thanh toán đơn hàng này?", titleAction: "Đồng ý") {
                            self.presenter?.confirmPayment()
                        } actionCancel: {

                        }
                    })
                    (cell as? FooterCreateSaleTableViewCell)?.notedTextfield.addAction(for: .editingDidEnd, closure: { (textfiled) in
                        self.presenter?.modelRequest.ghiChu = (textfiled as? UITextField)?.text ?? ""
                    })
                default:
                    (cell as? CustomerCreateSaleTableViewCell)?.item = item
                }
            }
        }

        dataSource?.didSelectRow = { (indexPath, item) in
            //            if let model = item?.property?.model {
            //                self.presenter?.detailAppointment(item: model)
            //            }
        }
    }
    private func configureTableViewSearch() {
        dataSourceSearch = TableDataSource<DefaultHeaderFooterModel<CustomFormModelElement>, DefaultCellModel<CustomFormModelElement>, CustomFormModelElement>.init(.SingleListing(items: self.itemSearch, identifier: SearchCustomerTableViewCell.identfier, height: UITableView.automaticDimension, leadingSwipe: nil, trailingSwipe: nil), self.tableViewSearch)

        dataSource?.addPullToRefresh = { [weak self] in
            self?.items.removeAll()
            self?.presenter?.updateDataFromModel()
        }

            dataSourceSearch?.configureCell = { (cell, item, indexPath) in                (cell as? SearchCustomerTableViewCell)?.item = item
            }

            dataSourceSearch?.addPullToRefresh = { [weak self] in
                //                      self?.pageNo = 0
                //                      self?.getNewDataWhenPulled()
                self?.dataSource?.stopInfiniteLoading(.FinishLoading)
            }

            dataSourceSearch?.addInfiniteScrolling = { [weak self] (page) in
                //                  self?.pageNo = (self?.pageNo ?? 0) + 1
                //                  self?.addMoreDataWithPaging()
            }
            dataSourceSearch?.didSelectRow = { (indexPath, item) in
                guard let model = item?.property?.model?.rawItem as? SearchCustomerAppointmentOptionalResponse else {
                    return
                }
                
                self.presenter?.getAvartaWithID(idx: model.id, model: model)
            }
        }
    // MARK: - Action Button

}

// MARK: - Protocol of Presenter
extension CreateSaleServiceViewController: CreateSaleServiceVC {
    func alertCreateMessage(text: String) {
        self.alertOneActionButton(title: "Đóng", description: text) {
            self.backToPrevScreen(with: RouteContext([RVIsReload: true]))
        }
    }

    func reCreateIdxSaleService() {
        self.alertTwoButton(description: "Lưu lại", titleAction: "Đồng ý") {
            self.presenter?.services()
        }
    }

    func updateTotalMoney(text: String) {
        self.totalLabel.text = text
    }

    func updateListSearchBar(items: [CustomFormModelElement]) {
        if items.count > 0 {
            self.viewListSearchBar.isHidden = false
        } else {
            self.viewListSearchBar.isHidden = true
        }
        self.itemSearch.removeAll()
        self.itemSearch = items
        self.dataSourceSearch?.updateAndReload(for: .SingleListing(items: items), .FullReload)
    }

    func initData(data: [ViewCreateSale]) {
        self.items = data
        let trangthai = self.items.first?.items?.first?.property?.model?.customer?.trangThaiSwipe ?? 0
        if trangthai == 0 {
            
            let saveItem = UIBarButtonItem.button(image: UIImage(named: "ic-floppy-disk")!, title: "", target: self, action: #selector(self.actionSave))
            self.navigationItem.rightBarButtonItems = [saveItem]
        }
        self.dataSource?.updateAndReload(for: .MultipleSection(items: data), .FullReload)
    }

    func reloadData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dataSource?.stopInfiniteLoading(.FinishLoading)
            self.dataSourceSearch?.stopInfiniteLoading(.FinishLoading)
        }
    }
}

extension CreateSaleServiceViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
        self.viewListSearchBar.isHidden = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        self.viewListSearchBar.isHidden = true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter?.searchService(search: searchText)
    }
}
