//
//  CreateSaleServicePresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/30/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol CreateSaleServiceVC: BaseView {
    func initData(data:[ViewCreateSale])
    func reloadData()
    func updateListSearchBar(items: [CustomFormModelElement])
    func updateTotalMoney(text: String)
    func reCreateIdxSaleService()
    func alertCreateMessage(text: String)
}

enum CreateSaleTableSectionEnum : Int {
    case Header = 0
    case Body = 1
    case Footer = 2
}

class CreateSaleServicePresenter: BasePresenter<CreateSaleServiceVC> {
    private let service = CreateSaleServiceService()
    
    var models : [ViewCreateSale] = []
    var IDService: Int?
    var IDGetAvarta: String?
    var backContext: ViewProductSalesService?
    var backListServiceContext: ListService?
    var backFooterServiceContext: FooterService?
    var modelRequest: SaleCsServiceRequest = SaleCsServiceRequest()
    
    var modelCancelRequest: CancelPaymentRequest = CancelPaymentRequest(hoSoId: 0)
    var modelPaymentRequest: ConfirmPaymentRequest = ConfirmPaymentRequest(hoSoId: 0, trangThai: 4)
    
    // MARK - Private Function
    func initDataPresent() {
        self.IDService = context?["IDService"]
        self.IDGetAvarta = context?[KGetAvarta]
        if let idx = self.IDService {
            self.modelCancelRequest.hoSoId = idx
            self.modelPaymentRequest.hoSoId = idx
            self.detailService(model: CreateSaleServiceRequest(idHoSo: idx))
        } else if let idxAvarta = self.IDGetAvarta {
            createListSale()
            updateDataFromModel()
            self.searchMaKhachHangService(search: idxAvarta)
        } else {
            createListSale()
            updateDataFromModel()
        }
    }
    
    func services() {
        Loading.startAnimation()
        self.service.createIdxSaleService(requestData: TestRequest()) { (response, status, code) in
            self.service.handleObjectStatus(modelOptionalResponse: SaleIdxOptionalResponse.self, response: response, status, code, successBlock: { (repo) in
                if let data = repo.data {
                    self.modelRequest.stt = data.stt ?? 0
                    self.modelRequest.maHoSo = data.maHoSo ?? ""
                    
                    self.modelRequest.bSuDungGoi = false
                    self.modelRequest.ghiChu = ""
                    self.modelRequest.idHoSo = 0
                    if let headerService = self.models[CreateSaleTableSectionEnum.Header.rawValue].items?.first?.property?.model?.customer {
                        self.modelRequest.hoTen = headerService.hoTen ?? ""
                        self.modelRequest.khachHangId = headerService.id ?? 0
                        self.modelRequest.maKhachHang = headerService.maHoSo
                        self.modelRequest.ngayDen = Date().getFormattedDate(format: "dd/MM/yyyy HH:mm:ss")
                        
                    }
                    
                    if let bodyService = self.models[CreateSaleTableSectionEnum.Body.rawValue].items {
                        self.modelRequest.lstSanPhamDichVuThe = []
                        var modelDichVu:[LstsssSanPhamDichVuThe] = []
                        for item in bodyService {
                            let itemData = (item.property?.model?.listService)
                            var model = LstsssSanPhamDichVuThe()
                            model.donGia = itemData?.donGia ?? 0.0
                            model.donvi = itemData?.donvi ?? 0
                            model.giamGia = itemData?.giamGia ?? 0.0
                            model.htGiamGia = itemData?.htGiamGia ?? 0.0
                            model.htTraHoaHong = Double(itemData?.htTraHoaHong ?? 0)
                            model.idChuongTrinhKm = itemData?.promotion?.idChuongTrinhKM ?? 0
                            model.idNguonGioiThieu = itemData?.idNguonGioiThieu ?? 0
                            model.id = itemData?.id ?? 0
                            model.idCt = itemData?.idCT ?? 0
                            model.listIdTuVanVien = itemData?.listIDTuVanVien ?? ""
                            model.maGiamGia = itemData?.maGiamGia ?? ""
                            model.maGiamGiaTien = Double(itemData?.maGiamGiaTien ?? 0)
                            model.nguonGioiThieuSoDienThoai = itemData?.sdtNguonGioiThieu ?? ""
                            model.nguonGioiThieuTen = itemData?.nguonGioiThieu ?? ""
                            model.soLuong = itemData?.soLuong ?? 0.0
                            model.thanhTien = itemData?.thanhTien ?? 0.0
                            model.thanhTienGiamGia = itemData?.thanhTienGiamGia ?? 0.0
                            model.thanhTienThanhToan = itemData?.thanhTienThanhToan ?? 0.0
                            model.tienGiam = itemData?.thanhTienThanhToan ?? 0.0
                            model.tienHoaHong = itemData?.tienHoaHong ?? 0.0
                            model.trangThai = itemData?.trangthaiSwipe ?? 0
                            model.type = itemData?.loai ?? ""
                            
                            modelDichVu.append(model)
                        }
                        self.modelRequest.lstSanPhamDichVuThe = modelDichVu
                    }
                    
                    
                    if let footerService = self.models[CreateSaleTableSectionEnum.Footer.rawValue].items?.first?.property?.model?.footer {
                        self.modelRequest.tongTien = footerService.tongTien ?? 0.0
                        self.modelRequest.tongTienGiamGiaDvSpThe = footerService.tongTienGiamGiaDVSPTHE ?? 0.0
                        self.modelRequest.tongTienGiamGiaHd = footerService.tongTienGiamGiaHD ?? 0.0
                        self.modelRequest.tongTienThanhToan = footerService.tongTienThanhToan ?? 0.0
                        self.modelRequest.lstGiamGiaHoSoKhachHang = footerService.lstGiamGiaHoSoKhachHang
                        self.modelRequest.ghiChu = footerService.ghiChu ?? ""
                    }
                    self.service.createSaleService(requestData: self.modelRequest)  { (response, status, code) in
                        self.service.handleObjectStatus(modelOptionalResponse: CreateSaleServiceDataClass.self, response: response, status, code, successBlock: { (repo) in
                            if let data = repo.data {
                                self.modelCancelRequest.hoSoId = data.idHoSo ?? 0
                                self.modelPaymentRequest.hoSoId = data.idHoSo ?? 0
                                Loading.stopAnimation()
                                self.viewController?.alertCreateMessage(text: repo.msg ?? "")
                            }
                        }) { (repo) in
                            //
                            Loading.stopAnimation()
                        }
                    }
                }
            }) { (repo) in
                Loading.stopAnimation()
                self.viewController?.reCreateIdxSaleService()
            }
        }
    }
    
    func updateBackContextData(context: RouteContext) {
        self.backContext = context[RVBackContext]
        if let backModel = self.backContext {
            self.updateListService(backModel: backModel)
        }
        
        self.backListServiceContext = context["BackListServiceContext"]
        if let modelListService = self.backListServiceContext {
            self.updateListServiceInEditer(model: modelListService)
        }
        
        self.backFooterServiceContext = context["BackFooterServiceContext"]
        if let backFooterService = self.backFooterServiceContext {
            self.models[CreateSaleTableSectionEnum.Footer.rawValue].items?.first?.property?.model?.footer = backFooterService
        }
        
        self.updateFooter()
        
        self.updateDataFromModel()
    }
    
    func insertOrUpdateModel(model: CellViewCreateSale) {
        if self.models.count == 2 {
            self.models.insert(ViewCreateSale(nil, nil, []), at: CreateSaleTableSectionEnum.Body.rawValue)
            //Check Exit
            if let listService = self.models[CreateSaleTableSectionEnum.Body.rawValue].items {
                if let index = self.checkExits(from: listService, user: model) {
                    //                    self.models[CreateSaleTableSectionEnum.Body.rawValue].items?[index] = model
                } else {
                    self.models[CreateSaleTableSectionEnum.Body.rawValue].items?.append(model)
                }
            }
        } else {
            if let listService = self.models[CreateSaleTableSectionEnum.Body.rawValue].items {
                if let index = self.checkExits(from: listService, user: model) {
                    //                    self.models[CreateSaleTableSectionEnum.Body.rawValue].items?[index] = model
                } else {
                    self.models[CreateSaleTableSectionEnum.Body.rawValue].items?.append(model)
                }
            }
        }
    }
    
    func createListSale() {
        models.removeAll()
        // CreateSaleTableSectionEnum.Header
        var headerCellData:[CellViewCreateSale] = []
        let headerCellView:CellViewCreateSale = CellViewCreateSale((identifier: HeaderCreateSaleTableViewCell.identfier, height: 230.0, model: ViewCreateSaleService(header: nil, customer: nil, listService: nil, footer: nil)))
        headerCellData.append(headerCellView)
        models.append(ViewCreateSale(nil, nil, headerCellData))
        
        // CreateSaleTableSectionEnum.Footer
        var footerCellData:[CellViewCreateSale] = []
        let footerCellView:CellViewCreateSale = CellViewCreateSale((identifier: FooterCreateSaleTableViewCell.identfier, height: UITableView.automaticDimension, model: ViewCreateSaleService(header: nil, customer: nil, listService: nil, footer: nil)))
        footerCellData.append(footerCellView)
        models.append(ViewCreateSale(nil, nil, footerCellData))
    }
    
    func updateCustomer(customer: SearchCustomerAppointmentOptionalResponse) {
        // CreateSaleTableSectionEnum.Header
        var headerCellData:[CellViewCreateSale] = []
        let headerCellView:CellViewCreateSale = CellViewCreateSale((identifier: CustomerCreateSaleTableViewCell.identfier, height: 230.0, model: ViewCreateSaleService(header: nil, customer: customer, listService: nil, footer: nil)))
        headerCellData.append(headerCellView)
        models[CreateSaleTableSectionEnum.Header.rawValue] = ViewCreateSale(nil, nil, headerCellData)
        updateDataFromModel()
    }
    
    func updateListService(backModel: ViewProductSalesService) {
        var arrayNew: [CellViewCreateSale] = []
        if let itemService = backModel.serviceProduct {
            for item in itemService {
                let first = ListService()
                first.donGia = item.donGia
                first.donvi = item.idDonGiaDV
                first.giamGia = 0.0
                first.htGiamGia = 0.0
                first.htTraHoaHong = 0
                //                first.IDChuongTrinhKM
                first.idNguonGioiThieu = 0
                first.id = item.idDichVu
                first.idCT = item.idDichVu
                first.listIDTuVanVien = ""
                first.maGiamGia = ""
                first.maGiamGiaTien = 0
                first.sdtNguonGioiThieu = ""
                first.tenNguonGioiThieu = ""
                first.soLuong = 1.0
                first.thanhTien = item.donGia
                first.thanhTienGiamGia = 0.0
                first.thanhTienThanhToan = item.donGia
                first.tienGiam = 0.0
                first.tienHoaHong = 0.0
                first.trangThai = 0
                first.anhDaiDien = item.anhDichVu
                first.ten =  item.tenDichVu
                first.soLuong = 1
                first.loai = "DICH_VU"
                let bodyCellView:CellViewCreateSale = CellViewCreateSale((identifier: ListServiceCreateSaleTableViewCell.identfier, height: UITableView.automaticDimension, model: ViewCreateSaleService(header: nil, customer: nil, listService: first, footer: nil)))
                self.insertOrUpdateModel(model: bodyCellView)
                arrayNew.append(bodyCellView)
            }
        }
        if let itemCard = backModel.cardProduct {
            for item in itemCard {
                let first = ListService()
                first.donGia = item.donGiaBan
                first.donvi = item.idTheDichVu
                first.giamGia = 0.0
                first.htGiamGia = 0.0
                first.htTraHoaHong = 0
                //                first.IDChuongTrinhKM
                first.idNguonGioiThieu = 0
                first.id = item.idTheDichVu
                first.idCT = item.idTheDichVu
                first.listIDTuVanVien = ""
                first.maGiamGia = ""
                first.maGiamGiaTien = 0
                first.sdtNguonGioiThieu = ""
                first.tenNguonGioiThieu = ""
                first.soLuong = 1.0
                first.thanhTien = item.donGiaBan
                first.thanhTienGiamGia = 0.0
                first.thanhTienThanhToan = item.donGiaBan
                first.tienGiam = 0.0
                first.tienHoaHong = 0.0
                first.trangThai = 0
                
                first.anhDaiDien = item.anhTheDichVu
                first.ten =  item.tenLoaiTheDichVu
                first.loai = "THE"
                let bodyCellView:CellViewCreateSale = CellViewCreateSale((identifier: ListServiceCreateSaleTableViewCell.identfier, height: UITableView.automaticDimension, model: ViewCreateSaleService(header: nil, customer: nil, listService: first, footer: nil)))
                self.insertOrUpdateModel(model: bodyCellView)
                arrayNew.append(bodyCellView)
            }
        }
        if let itemCatalog = backModel.catalogProduct {
            for item in itemCatalog {
                let first = ListService()
                first.donGia = item.giaNiemYet
                first.donvi = item.id
                first.giamGia = 0.0
                first.htGiamGia = 0.0
                first.htTraHoaHong = 0
                //                first.IDChuongTrinhKM
                first.idNguonGioiThieu = 0
                first.id = item.id
                first.idCT = item.id
                first.listIDTuVanVien = ""
                first.maGiamGia = ""
                first.maGiamGiaTien = 0
                first.sdtNguonGioiThieu = ""
                first.tenNguonGioiThieu = ""
                first.soLuong = 1.0
                first.thanhTien = item.giaNiemYet
                first.thanhTienGiamGia = 0.0
                first.thanhTienThanhToan = item.giaNiemYet
                first.tienGiam = 0.0
                first.tienHoaHong = 0.0
                first.trangThai = 0
                
                first.anhDaiDien = item.anhSanPham
                first.ten =  item.tenSanPham
                first.loai = "SAN_PHAM"
                let bodyCellView:CellViewCreateSale = CellViewCreateSale((identifier: ListServiceCreateSaleTableViewCell.identfier, height: UITableView.automaticDimension, model: ViewCreateSaleService(header: nil, customer: nil, listService: first, footer: nil)))
                self.insertOrUpdateModel(model: bodyCellView)
                arrayNew.append(bodyCellView)
            }
        }
        
        if let listItem = self.models[CreateSaleTableSectionEnum.Body.rawValue].items {
            for (index,itemOld) in listItem.enumerated() {
                let idxOld = itemOld.property?.model?.listService?.id ?? -1
                var exited: Bool = false
                
                for (_,itemNew) in arrayNew.enumerated() {
                    let idxNew = itemNew.property?.model?.listService?.id ?? -2
                    if idxNew == idxOld {
                        exited = true
                    }
                }
                
                if exited == false {
                    self.deleteProduct(index: index)
                }
                
            }
        }
    }
    
    func updateFooter() {
        var ghiChu = ""
        var tongTienGiamGiaHD = 0.0
        var tongTienThanhToan = 0.0
        var tongTien = 0.0
        var tongTienGiamGiaDVSPTHE  = 0.0

        var footerServiceNew = FooterService(ghiChu: ghiChu, tongTienGiamGiaHD: tongTienGiamGiaHD, tongTienThanhToan: tongTienThanhToan, tongTien: tongTien, tongTienGiamGiaDVSPTHE: tongTienGiamGiaDVSPTHE)

        if self.models.indices.contains(CreateSaleTableSectionEnum.Body.rawValue) == true {
            if let listService = self.models[CreateSaleTableSectionEnum.Body.rawValue].items {
                for item in listService {
                    if (item.property?.model?.listService?.donGiaNew ?? -1) > 0 {
                        tongTien += item.property?.model?.listService?.donGiaNew ?? 0.0
                    } else {
                        tongTien += item.property?.model?.listService?.donGia ?? 0.0
                    }
                    tongTienGiamGiaDVSPTHE += item.property?.model?.listService?.thanhTienGiamGia ?? 0.0
                    //                tongTienThanhToan += item.property?.model?.listService?.tienThanhToan ?? 0.0
                }
            }
        }
        
        if self.models.indices.contains(CreateSaleTableSectionEnum.Footer.rawValue) == true {
            if let footerService = self.models[CreateSaleTableSectionEnum.Footer.rawValue].items {
                if let foModel = footerService.first?.property?.model?.footer {
                    footerServiceNew = foModel
                }
                if let promotion = footerService.first?.property?.model?.footer?.promotion {
                    let newTotal = tongTien - tongTienGiamGiaDVSPTHE
                    let discountNumber = promotion.giamTang ?? 0.0
                    if promotion.tienOrPhanTram == true {
                        let totalDiscountNumber = discountNumber + (footerService.first?.property?.model?.footer?.discountPoint ?? 0.0)
//                            + (footerService.first?.property?.model?.footer?.discountPromotion ?? 0.0)
                        tongTienGiamGiaHD = newTotal - totalDiscountNumber
                    } else {
                        let countDis = (discountNumber / 100 * (newTotal))
                        let totalDiscountNumber = countDis +  (footerService.first?.property?.model?.footer?.discountPoint ?? 0.0)
//                            + (footerService.first?.property?.model?.footer?.discountPromotion ?? 0.0)
                        tongTienGiamGiaHD = totalDiscountNumber
                    }
                }
                else if footerService.first?.property?.model?.footer?.valueThanhTienGiamGia ?? 0.0 > 0.0 {
                    let newTotal = tongTien - tongTienGiamGiaDVSPTHE
                    let discountNumber = footerService.first?.property?.model?.footer?.valueThanhTienGiamGia ?? 0.0
                    if footerService.first?.property?.model?.footer?.typeThanhTienGiamGia == true {
                        let totalDiscountNumber = discountNumber + (footerService.first?.property?.model?.footer?.discountPoint ?? 0.0) + (footerService.first?.property?.model?.footer?.discountPromotion ?? 0.0)
                        tongTienGiamGiaHD = totalDiscountNumber
                    } else {
                        let countDis = (discountNumber / 100 * (newTotal))
                        let totalDiscountNumber = countDis +  (footerService.first?.property?.model?.footer?.discountPoint ?? 0.0)
//                            + (footerService.first?.property?.model?.footer?.discountPromotion ?? 0.0)
                        tongTienGiamGiaHD = totalDiscountNumber
                    }
                }
                else {
                    tongTienGiamGiaHD = footerService.first?.property?.model?.footer?.tongTienGiamGiaHD ?? 0.0
                }
            }
        }
        
        tongTienThanhToan = tongTien - tongTienGiamGiaDVSPTHE - tongTienGiamGiaHD
        footerServiceNew.tongTienThanhToan = tongTienThanhToan
        footerServiceNew.ghiChu = ghiChu
        footerServiceNew.tongTienGiamGiaHD = tongTienGiamGiaHD
        footerServiceNew.tongTien = tongTien
        footerServiceNew.tongTienGiamGiaDVSPTHE = tongTienGiamGiaDVSPTHE

        self.viewController?.updateTotalMoney(text: tongTienThanhToan.formatnumberWithCurrency())
        var footerCellData:[CellViewCreateSale] = []
        
        let footerCellView:CellViewCreateSale = CellViewCreateSale((identifier: FooterCreateSaleTableViewCell.identfier, height: UITableView.automaticDimension, model: ViewCreateSaleService(header: nil, customer: nil, listService: nil, footer: footerServiceNew)))
        footerCellData.append(footerCellView)
        self.models[CreateSaleTableSectionEnum.Footer.rawValue] = ViewCreateSale(nil, nil, footerCellData)
    }
    
    func updateDataFromModel() {
        self.viewController?.initData(data: self.models)
        self.viewController?.reloadData()
    }
    
    func addListService() {
        self.viewController?.openChildScreen(.ProductSalesServiceViewController, fromStoryboard: .Sales, withContext: RouteContext([RVContext:self.models]))
    }
    
    func addInvoteService() {
        if let customer = self.models[CreateSaleTableSectionEnum.Header.rawValue].items?.first?.property?.model?.customer {
            if let models = self.models[CreateSaleTableSectionEnum.Footer.rawValue].items?.first?.property?.model?.footer {
                self.viewController?.openChildScreen(.EditInvoveServiceViewController, fromStoryboard: .Sales, withContext: RouteContext([RVContext:models,"RVCustomer":customer]))
            }
        } else {
            Loading.notificationError(title: "", subtitle: "Vui lòng chọn khách hàng")
        }
    }
    
    func searchMaKhachHangService(search: String) {
        self.service.searchCustomerService(requestData: SearchCustomerAppointmentRequest(keyWord: search)) { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [SearchCustomerAppointmentOptionalResponse].self, response: response, status, code, successBlock: { (repo) in
                
                if let data = repo.data?.first {
                    self.getAvartaWithID(idx: data.id, model: data)
                }
            }) { (repo) in
                
            }
        }
    }
    
    func searchService(search: String) {
        self.service.searchCustomerService(requestData: SearchCustomerAppointmentRequest(keyWord: search)) { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [SearchCustomerAppointmentOptionalResponse].self, response: response, status, code, successBlock: { (repo) in
                
                var items : [CustomFormModelElement] = []
                if let data = repo.data {
                    for item in data {
                        items.append(CustomFormModelElement(selected: item.hoTen, rawItem: item as AnyObject, isSelected: false))
                    }
                }
                self.viewController?.updateListSearchBar(items: items)
            }) { (repo) in
                
            }
        }
    }
    
    func getAvartaWithID(idx: Int?, model: SearchCustomerAppointmentOptionalResponse) {
        self.service.customerDetailService(model: CustomerDetailRequest(id: idx), callBack: { (response, status, code) in
            self.service.handleObjectStatus(modelOptionalResponse: CustomerDetailOptionalResponse.self, response: response, status, code, successBlock: { (repo) in
                var modelss = model
                if let data = repo.data {
                    modelss.anhKhachHang = data.anhKhachHang ?? ""
                }
                self.updateCustomer(customer: modelss)
            }) { (repo) in
                self.updateCustomer(customer: model)
            }
        })
    }
    
    // MARK: - Navigation
    func detailService(model: CreateSaleServiceRequest) {
        self.service.detailSaleService(requestData: model) { (response, status, code) in
            self.service.handleObjectStatus(modelOptionalResponse: CreateSaleServiceOptionalResponse.self, response: response, status, code, successBlock: { (repo) in
                if let data = repo.data {
                    //                    self.modelRequest = data
                    // Header
                    var headerCellData:[CellViewCreateSale] = []
                    var custommer = SearchCustomerAppointmentOptionalResponse(hoTen: data.hoTen)
                    custommer.ngayDen = data.ngayDen ?? ""
                    custommer.maHoSo = data.maHoSo ?? ""
                    custommer.trangThaiSwipe = data.trangThai ?? 0
                    custommer.trangThaiSwipeText = data.trangThaiText ?? ""
                    let headerCellView:CellViewCreateSale = CellViewCreateSale((identifier: CustomerCreateSaleTableViewCell.identfier, height: 230.0, model: ViewCreateSaleService(header: nil, customer: custommer, listService: nil, footer: nil)))
                    headerCellData.append(headerCellView)
                    self.models.append(ViewCreateSale(nil, nil, headerCellData))
                    // BODY
                    var bodyCellData:[CellViewCreateSale] = []
                    if let items = data.dichVuSanPhamThe {
                        for item in items {
                            // DANH SÁCH MUA HÀNG
                            
                            let first = ListService(rowID: item.rowID, loai: item.loai, id: item.id, ten: item.ten, soLuong: item.soLuong, donGia: item.donGia, thanhTien: item.thanhTien, giamGia: item.giamGia, thanhTienGiamGia: item.thanhTienGiamGia, tienThanhToan: item.tienThanhToan, htGiamGia: item.htGiamGia, anhDaiDien: item.anhDaiDien, tenDonVi: item.tenDonVi, htTraHoaHong: item.htTraHoaHong, maGiamGiaTien: item.maGiamGiaTien, idNguonGioiThieu: item.idNguonGioiThieu, listIDTuVanVien: item.listIDTuVanVien, maGiamGia: item.maGiamGia, idCT: item.idCT, trangThai: item.trangThai, listIDNhanVien: item.listIDNhanVien, sdtNguonGioiThieu: item.sdtNguonGioiThieu, hoaHongTraNVTuVan: item.hoaHongTraNVTuVan, maQuanLyDV: item.maQuanLyDV, nguonGioiThieu: item.nguonGioiThieu, listTenNhanVienTuVan: item.listTenNhanVienTuVan, listTenNhanVien: item.listTenNhanVien, tenNguonGioiThieu: item.nguonGioiThieu, thanhTienThanhToan: item.thanhTien, tienGiam: item.thanhTienGiamGia, tienHoaHong: item.hoaHongTraNVTuVan, donvi: 0)
                            
                            first.trangthaiSwipe = data.trangThai ?? 0
                            
                            let bodyCellView:CellViewCreateSale = CellViewCreateSale((identifier: ListServiceCreateSaleTableViewCell.identfier, height: UITableView.automaticDimension, model: ViewCreateSaleService(header: nil, customer: custommer, listService: first, footer: nil)))
                            bodyCellData.append(bodyCellView)
                        }
                    }
                    self.models.append(ViewCreateSale(nil, nil, bodyCellData))
                    // Footer
                    var footerCellData:[CellViewCreateSale] = []
                    let fotterSa = FooterService(ghiChu: data.ghiChu, tongTienGiamGiaHD: data.tongTienGiamGiaHD, tongTienThanhToan: data.tongTienThanhToan, tongTien: data.tongTien, tongTienGiamGiaDVSPTHE: data.tongTienGiamGiaDVSPTHE)
                    fotterSa.trangthaiSwipe = data.trangThai ?? 0
                    let footerCellView:CellViewCreateSale = CellViewCreateSale((identifier: FooterCreateSaleTableViewCell.identfier, height: UITableView.automaticDimension, model: ViewCreateSaleService(header: nil, customer: nil, listService: nil, footer: fotterSa)))
                    footerCellData.append(footerCellView)
                    self.models.append(ViewCreateSale(nil, nil, footerCellData))
                    self.viewController?.updateTotalMoney(text: data.tongTienThanhToan?.formatnumberWithCurrency() ?? 0.formatnumberWithCurrency())
                    self.updateDataFromModel()
                }
            }) { (repo) in
                
            }
        }
    }
    // MARK: - Delete Product
    func deleteProduct(index: Int) {
        self.models[CreateSaleTableSectionEnum.Body.rawValue].items?.remove(at: index)
        self.updateFooter()
        self.updateDataFromModel()
    }
    // MARK: - Check exit
    func checkExits(from: [CellViewCreateSale], user: CellViewCreateSale) -> Int? {
        for (index,item) in from.enumerated() {
            if let idxRoot = item.property?.model?.listService?.id {
                if let idxChild = user.property?.model?.listService?.id {
                    if idxRoot == idxChild {
                        return index
                    }
                }
            }
        }
        return nil
    }
    
    // MARK: - Update list service
    
    func updateListServiceInEditer(model: ListService) {
        if let listService = self.models[CreateSaleTableSectionEnum.Body.rawValue].items {
            for (index,item) in listService.enumerated() {
                if item.property?.model?.listService?.id == model.id {
                    self.models[CreateSaleTableSectionEnum.Body.rawValue].items?[index].property?.model?.listService = model
                    break
                }
            }
        }
    }
    
    
    func openEditer(item: ListService) {
        if item.loai == "SAN_PHAM" {
            self.viewController?.openChildScreen(.EditProductServiceViewController, fromStoryboard: .Sales, withContext: RouteContext([RVContext: item]))
        } else if item.loai == "DICH_VU" {
            self.viewController?.openChildScreen(.EditSpaServiceViewController, fromStoryboard: .Sales, withContext: RouteContext([RVContext: item]))
        } else {
            self.viewController?.openChildScreen(.EditCardServiceViewController, fromStoryboard: .Sales, withContext: RouteContext([RVContext: item]))
        }
    }
    
    func cancelPayment() {
        self.service.cancelPayment(requestData: self.modelCancelRequest) { (response, status, code) in
            self.service.handleObjectStatus(modelOptionalResponse: TestRequest.self, response: response, status, code, successBlock: { (repo) in
                self.viewController?.alertCreateMessage(text: repo.msg ?? "")
            }) { (repo) in
                
            }
        }
        
    }
    
    func confirmPayment() {
        self.service.confirmPayment(requestData: self.modelPaymentRequest) { (response, status, code) in
            self.service.handleObjectStatus(modelOptionalResponse: TestRequest.self, response: response, status, code, successBlock: { (repo) in
                self.viewController?.alertCreateMessage(text: repo.msg ?? "")
            }) { (repo) in
                
            }
        }
    }
}
