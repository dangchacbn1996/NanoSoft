//
//  Common.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/3/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit
import SDWebImage

//Truy suất thông tin trên UserDefault
class Common {
    static func stringToUrlImage(text: String) -> String {
        //domain/Images/urlimage
        let domain = Common.HOST
        return "\(domain)\(text)"
    }
    
    static func stringToUrlReport(text: String) -> String {
        let brandType = Common.BRAND_TYPE
        if brandType == BrandTypeEnum.Staff.rawValue {
            return "\(Common.HOST)\(text)?sid=\(Common.BRAND_SID)&LoaiTaiKhoan=NHAN_VIEN"
        } else {
            return "\(Common.HOST)\(text)?sid=\(Common.BRAND_SID)&LoaiTaiKhoan=KHACH_HANG"
        }
    }
    
    static func stringToUrlExt() -> String {
        let brandType = Common.BRAND_TYPE
        
        if brandType == BrandTypeEnum.Staff.rawValue {
            let Applinkext = UserDefaults.standard.df.fetch(forKey: String(describing: SignInResponseDataClass.self), type: SignInResponseDataClass.self)?.Applinkext ?? ""
            return "\(Applinkext)?sid=\(Common.BRAND_SID)&LoaiTaiKhoan=NHAN_VIEN&MaCongTy=\(Common.BRAND_NUMBER)"
        } else {
            let Applinkext = UserDefaults.standard.df.fetch(forKey: String(describing: CustomerProfileOptionalResponse.self), type: CustomerProfileOptionalResponse.self)?.Applinkext ?? ""
            return "\(Applinkext)?sid=\(Common.BRAND_SID)&LoaiTaiKhoan=KHACH_HANG&MaCongTy=\(Common.BRAND_NUMBER)"
        }
    }
    
    static var urlReport: String {
        get {
            let brandType = Common.BRAND_TYPE
            if brandType == BrandTypeEnum.Staff.rawValue {
                let data = UserDefaults.standard.df.fetch(forKey: String(describing: SignInResponseDataClass.self), type: SignInResponseDataClass.self)?.urlReportArb ?? ""
                return "\(Common.HOST)\(data)sid=\(Common.BRAND_SID)&LoaiTaiKhoan=NHAN_VIEN"
            } else {
                let data = UserDefaults.standard.df.fetch(forKey: String(describing: CustomerProfileOptionalResponse.self), type: CustomerProfileOptionalResponse.self)?.dienThoai ?? ""
                return data
            }
        }
    }
    
    static func removeDuplicateElements(posts: [ServerSettingResponseDatum]) -> [ServerSettingResponseDatum] {
        var uniquePosts = [ServerSettingResponseDatum]()
        for post in posts {
            if !uniquePosts.contains(where: {$0.url == post.url }) {
                uniquePosts.append(post)
            }
        }
        return uniquePosts
    }
    
    static var Domain:ServerSettingResponseDatum? {
        set (newVal){
            
            let datas = UserDefaults.standard.df.fetch(forKey: String(describing: ListsDomain.self), type: ListsDomain.self)
            
            var dataSave = UserDefaults.standard.df.fetch(forKey: String(describing: ListsDomain.self), type: ListsDomain.self) ?? ListsDomain(data: [])
            if let daValidate = newVal {
                
                if let arrayData = datas?.data {
                    if arrayData.count > 0 {
                        for item in arrayData {
                            print(item.url)
                            print(daValidate.url)
                            if item.url != daValidate.url {
                                dataSave.data.append(daValidate)
                                break
                            }
                        }
                    } else {
                        dataSave.data.append(daValidate)
                    }
                } else {
                    dataSave.data.append(daValidate)
                }
                dataSave.data = Common.removeDuplicateElements(posts: dataSave.data)
                
                UserDefaults.standard.df.store(dataSave, forKey: String(describing: ListsDomain.self))
                
                _ = UserDefaults.standard.df.fetch(forKey: String(describing: ListsDomain.self), type: ListsDomain.self)
            }
        }
        get {
            return UserDefaults.standard.df.fetch(forKey: String(describing: ServerSettingResponseDatum.self), type: ServerSettingResponseDatum.self)
        }
    }

    static var ListDomain:[ServerSettingResponseDatum] {
        get {
            return UserDefaults.standard.df.fetch(forKey: String(describing: ListsDomain.self), type: ListsDomain.self)?.data ?? []
        }
    }
    
    static var HostCurrent:ServerSettingResponseDatum? {
        get {
            return UserDefaults.standard.df.fetch(forKey: String(describing: ServerSettingResponseDatum.self), type: ServerSettingResponseDatum.self)
        }
    }
    
    static var HOST:String {
        get {
            return UserDefaults.standard.df.fetch(forKey: String(describing: ServerSettingResponseDatum.self), type: ServerSettingResponseDatum.self)?.url ?? ""
        }
    }
    static var BRAND_DOMAIN:String {
        get {
            return UserDefaults.standard.df.fetch(forKey: String(describing: ServerSettingResponseDatum.self), type: ServerSettingResponseDatum.self)?.domain ?? ""
        }
    }
    static var BRAND_NAME:String {
        get {
            return UserDefaults.standard.df.fetch(forKey: String(describing: ServerSettingResponseDatum.self), type: ServerSettingResponseDatum.self)?.tenThuongHieu ?? ""
        }
    }
    
    static var BRAND_LOGO:String {
        get {
            return UserDefaults.standard.df.fetch(forKey: String(describing: ServerSettingResponseDatum.self), type: ServerSettingResponseDatum.self)?.logo ?? ""
        }
    }
    
    static var BRAND_TYPE:String {
        get {
            let string =
                UserDefaults.standard.df.fetch(forKey: String(describing: ServerSettingStore.self), type: ServerSettingStore.self)?.brandType ?? ""
            return string
        }
    }
    
    static var IS_GUEST:Bool {
        get {
            let isGuest =
                UserDefaults.standard.df.fetch(forKey: String(describing: GuestModel.self), type: GuestModel.self)?.isGuest ?? false
            return isGuest
        }
    }
    
    
    static var BRAND_NUMBER:String {
        get {
            return UserDefaults.standard.df.fetch(forKey: String(describing: ServerSettingResponseDatum.self), type: ServerSettingResponseDatum.self)?.maCongTy ?? ""
        }
    }
    
    static var BRAND_PHONE_NUMBER:String {
        get {
            return UserDefaults.standard.df.fetch(forKey: String(describing: ServerSettingResponseDatum.self), type: ServerSettingResponseDatum.self)?.dienThoai ?? ""
        }
    }
    
    static var BRAND_USER:String {
        get {
            let brandType = Common.BRAND_TYPE
            if brandType == BrandTypeEnum.Staff.rawValue {
                let data = UserDefaults.standard.df.fetch(forKey: String(describing: SignInResponseDataClass.self), type: SignInResponseDataClass.self)?.username ?? ""
                return data
            } else {
                let data = UserDefaults.standard.df.fetch(forKey: String(describing: CustomerProfileOptionalResponse.self), type: CustomerProfileOptionalResponse.self)?.dienThoai ?? ""
                return data
            }
        }
    }
    
    static var BRAND_USER_ID:Int {
        get {
            let brandType = Common.BRAND_TYPE
            if brandType == BrandTypeEnum.Staff.rawValue {
                return 0
            } else {
                let idx = UserDefaults.standard.df.fetch(forKey: String(describing: CustomerProfileOptionalResponse.self), type: CustomerProfileOptionalResponse.self)?.id ?? 0
                return idx
            }
        }
    }
    
    static var BRAND_SID:String {
        get {
            let brandType = Common.BRAND_TYPE
            if brandType == BrandTypeEnum.Staff.rawValue {
                let data = UserDefaults.standard.df.fetch(forKey: String(describing: SignInResponseDataClass.self), type: SignInResponseDataClass.self)?.sid ?? ""
                return data
            } else {
                let data = UserDefaults.standard.df.fetch(forKey: String(describing: CustomerProfileOptionalResponse.self), type: CustomerProfileOptionalResponse.self)?.sid ?? ""
                return data
            }
            //                        return "6a6d1c34-13b5-4023-b0e6-c62c4e5bd1f8"
        }
    }
    
    static var sexData: [ModelOptionResponseSystemGenderCatalogDatum] {
        get {
            let data = UserDefaults.standard.df.fetch(forKey: String(describing: ModelOptionResponseSystemGenderCatalog.self), type: ModelOptionResponseSystemGenderCatalog.self)?.data ?? []
            return data
        }
    }
    
    static var cityData:  [ModelOptionResponseProvincesCatalogDatum] {
        get {
            let data = UserDefaults.standard.df.fetch(forKey: String(describing: ModelOptionResponseProvincesCatalog.self), type: ModelOptionResponseProvincesCatalog.self)?.data ?? []
            return data
        }
    }
    
    static var districtData:  [ModelOptionResponseDistrictsByProvinceCodeCatalogDatum] {
        get {
            let data = UserDefaults.standard.df.fetch(forKey: String(describing: ModelOptionResponseDistrictsByProvinceCodeCatalog.self), type: ModelOptionResponseDistrictsByProvinceCodeCatalog.self)?.data ?? []
            return data
        }
    }
    
    static var jobData:  [ModelOptionResponseOccupationCatalogDatum] {
        get {
            let data = UserDefaults.standard.df.fetch(forKey: String(describing: ModelOptionResponseOccupationCatalog.self), type: ModelOptionResponseOccupationCatalog.self)?.data ?? []
            return data
        }
    }
    
    static var referralData:  [ModelOptionResponseReferralCatalogDatum] {
        get {
            let data = UserDefaults.standard.df.fetch(forKey: String(describing: ModelOptionResponseReferralCatalog.self), type: ModelOptionResponseReferralCatalog.self)?.data ?? []
            return data
        }
    }
    
    static var sourceToData: [ModelOptionResponseSourceToCatalogDatum] {
        get {
            let data = UserDefaults.standard.df.fetch(forKey: String(describing: ModelOptionResponseSourceToCatalog.self), type: ModelOptionResponseSourceToCatalog.self)?.data ?? []
            return data
        }
    }
    static var sourceFromData: [ModelOptionResponseSourceToCatalogDatum] {
        get {
            let data = UserDefaults.standard.df.fetch(forKey: String(describing: ModelOptionResponseSourceToCatalog.self), type: ModelOptionResponseSourceToCatalog.self)?.data ?? []
            return data
        }
    }
    
    static var typeCustomerData: [ModelOptionResponseCustomerTypeCatalogDatum] {
        get {
            let data = UserDefaults.standard.df.fetch(forKey: String(describing: ModelOptionResponseCustomerTypeCatalog.self), type: ModelOptionResponseCustomerTypeCatalog.self)?.data ?? []
            return data
        }
    }
    
    static var typeStatusCatelogData: [ModelOptionResponseStatusCatalogDatum] {
        get {
            let data = UserDefaults.standard.df.fetch(forKey: String(describing: ModelOptionResponseStatusCatalog.self), type: ModelOptionResponseStatusCatalog.self)?.data ?? []
            return data
        }
    }
    
    static var typeInvoiceStatusCatelogData: [ModelOptionResponseInvoiceStatusCatalogDatum] {
        get {
            let data = UserDefaults.standard.df.fetch(forKey: String(describing: ModelOptionResponseInvoiceStatusCatalog.self), type: ModelOptionResponseInvoiceStatusCatalog.self)?.data ?? []
            return data
        }
    }
    
    static var typeStatusTreatmentData: [ModelOptionResponseStatusCatalogDatum] {
        get {
            var addAllInCurrentData: [ModelOptionResponseStatusCatalogDatum] = []
            addAllInCurrentData.append(ModelOptionResponseStatusCatalogDatum(id: 1, trangThai: "Chờ thực hiện"))
            addAllInCurrentData.append(ModelOptionResponseStatusCatalogDatum(id: 2, trangThai: "Đang thực hiện"))
            addAllInCurrentData.append(ModelOptionResponseStatusCatalogDatum(id: 3, trangThai: "Đã thực hiện"))
            addAllInCurrentData.append(ModelOptionResponseStatusCatalogDatum(id: 4, trangThai: "Đang điều trị"))
            addAllInCurrentData.append(ModelOptionResponseStatusCatalogDatum(id: 5, trangThai: "Hoàn thành"))
            return addAllInCurrentData
        }
    }
    static var addAllInStatusTreatmentData: [ModelOptionResponseStatusCatalogDatum] {
        get {
            var addAllInCurrentData: [ModelOptionResponseStatusCatalogDatum] = []
            addAllInCurrentData.append(ModelOptionResponseStatusCatalogDatum(id: 0, trangThai: "Tất cả"))
            addAllInCurrentData.append(ModelOptionResponseStatusCatalogDatum(id: 1, trangThai: "Chờ thực hiện"))
            addAllInCurrentData.append(ModelOptionResponseStatusCatalogDatum(id: 2, trangThai: "Đang thực hiện"))
            addAllInCurrentData.append(ModelOptionResponseStatusCatalogDatum(id: 3, trangThai: "Đã thực hiện"))
            addAllInCurrentData.append(ModelOptionResponseStatusCatalogDatum(id: 4, trangThai: "Đang điều trị"))
            addAllInCurrentData.append(ModelOptionResponseStatusCatalogDatum(id: 5, trangThai: "Hoàn thành"))
            return addAllInCurrentData
        }
    }
    
    static var addAllInStatusTreatmentEditData: [ModelOptionResponseStatusCatalogDatum] {
        get {
            var addAllInCurrentData: [ModelOptionResponseStatusCatalogDatum] = []
            addAllInCurrentData.append(ModelOptionResponseStatusCatalogDatum(id: 0, trangThai: "Chờ thực hiện"))
            addAllInCurrentData.append(ModelOptionResponseStatusCatalogDatum(id: 1, trangThai: "Đang thực hiện"))
            addAllInCurrentData.append(ModelOptionResponseStatusCatalogDatum(id: 2, trangThai: "Đã thực hiện"))
            return addAllInCurrentData
        }
    }
    
    static var addAllInTypeStatusCatelogData: [ModelOptionResponseStatusCatalogDatum] {
        var addAllInCurrentData: [ModelOptionResponseStatusCatalogDatum] = []
        let currentData = Common.typeStatusCatelogData
        addAllInCurrentData.append(contentsOf: currentData)
        addAllInCurrentData.insert(ModelOptionResponseStatusCatalogDatum(id: -1, trangThai: "Tất cả"), at: 0)
        return addAllInCurrentData
    }
    
    static var addAllInTypeInvoiceStatusCatelogData: [ModelOptionResponseInvoiceStatusCatalogDatum] {
        var addAllInCurrentData: [ModelOptionResponseInvoiceStatusCatalogDatum] = []
        let currentData = Common.typeInvoiceStatusCatelogData
        addAllInCurrentData.append(contentsOf: currentData)
        addAllInCurrentData.insert(ModelOptionResponseInvoiceStatusCatalogDatum(id: -1, trangThai: "Tất cả"), at: 0)
        return addAllInCurrentData
    }
    
    static var roomCatalogData: [ModelOptionResponseAppointmentScheduleCatalogDatum] {
        get {
            let data = UserDefaults.standard.df.fetch(forKey: String(describing: ModelOptionResponseAppointmentScheduleCatalog.self), type: ModelOptionResponseAppointmentScheduleCatalog.self)?.data ?? []
            return data
        }
    }
    
    static var employeeAndSearchCatalogData: [ModelOptionResponseEmployeeAndSearchCatalogDatum] {
        get {
            let data = UserDefaults.standard.df.fetch(forKey: String(describing: ModelOptionResponseEmployeeAndSearchCatalog.self), type: ModelOptionResponseEmployeeAndSearchCatalog.self)?.data ?? []
            return data
        }
    }
    
    static var serviceCatalogData: [ModelOptionResponseServiceCatalogDatum] {
        get {
            let data = UserDefaults.standard.df.fetch(forKey: String(describing: ModelOptionResponseServiceCatalog.self), type: ModelOptionResponseServiceCatalog.self)?.data ?? []
            return data
        }
    }
    
    static var promotionCatalogData: [PromotionProductOptionalResponse] {
        get {
            guard let data = UserDefaults.standard.df.fetch(forKey: String(describing: [PromotionProductOptionalResponse].self), type: [PromotionProductOptionalResponse].self) else { return []
            }
            return data
        }
    }
    
    static var unitCatalogData: [CheckProductOptionalResponse] {
        get {
            guard let data = UserDefaults.standard.df.fetch(forKey: String(describing: [CheckProductOptionalResponse].self), type: [CheckProductOptionalResponse].self) else { return []
            }
            return data
        }
    }
    
    static var socialCatalog: [ModelOptionResponseSocialCatalogDatum] {
        get {
            guard let data = UserDefaults.standard.df.fetch(forKey: String(describing: ModelOptionResponseSocialCatalog.self), type: ModelOptionResponseSocialCatalog.self)?.data else { return []
            }
            return data
        }
    }
    
    static func callNumber(phoneNumber:String) {
        let stringRemoveString = phoneNumber.replacingOccurrences(of: "^\\s+|\\s+|\\s+$",
                                                                  with: "",
                                                                  options: .regularExpression)
        
        if let phoneCallURL = URL(string: "tel://\(stringRemoveString)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                    application.openURL(phoneCallURL as URL)
                    
                }
            }
        }
    }
    
    static func statusWithColor(statusNumber: Int) -> (UIColor, UIImage?){
        if statusNumber == 0 {
            return (UIColor(hex: "9B9B9B"),  UIImage(named: "ic-wait"))
        } else if statusNumber == 1 {
            return (UIColor(hex: "4E94E4"),  UIImage(named: "ic-progerss"))
        } else if statusNumber == 2 {
            return (AppColors.primaryColor,  UIImage(named: "ic-success"))
        } 
        return (UIColor(hex: "9B9B9B"),  UIImage(named: "ic-progerss"))
    }
    
}


class CommonData: Common {
    static let shared = CommonData()
    
    private var _token = ""
    var token: String {
        set {
            _token = newValue
        }
        
        get {
            return "Bearer " + _token
        }
    }
}

class CommonView {
    
    static func alert(_ from: UIViewController, title: String, description: String, action: ((PMAlertController) -> Void)? = nil) {
        let alertVC = PMAlertController(title: "\(CommonString)Alert".localized, description: description, image: nil, style: .alert)
        
        alertVC.addAction(PMAlertAction(title: title, style: .default, action: {
            action?(alertVC)
        }))
        alertVC.modalPresentationStyle = .overFullScreen
        from.present(alertVC, animated: true, completion: nil)
    }
    
    static func alert(title: String, description: String, action: ((PMAlertController) -> Void)? = nil) {
        let alertVC = PMAlertController(title: "\(CommonString)Alert".localized, description: description, image: nil, style: .alert)
        
        alertVC.addAction(PMAlertAction(title: title, style: .default, action: {
            action?(alertVC)
        }))
        alertVC.modalPresentationStyle = .overFullScreen
        
        (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController?.present(alertVC, animated: true, completion: nil)
        
    }
    
    static func alertSex(selected: @escaping ((ModelOptionResponseSystemGenderCatalogDatum) -> Void)) {
        let actionSheet = MyActionSheet(cancelButtonTitle: "Filter.Cancel".localize())
        for item in Common.sexData {
            actionSheet.add(MyActionSheetItem(title: item.tenGioiTinh ?? "", handler: { _ in
                selected(item)
            }))
        }
        actionSheet.show()
    }
    
    static func alertCity(selected: @escaping ((ModelOptionResponseProvincesCatalogDatum) -> Void)) {
        let form = CustomFormViewController()
        form.isTypeCell = .ContentOnly
        var dataCommon:[CustomFormModelElement] = []
        dataCommon = Common.cityData.map({ (data) -> CustomFormModelElement in
            return CustomFormModelElement(selected: data.tenTinhThanh, rawItem: data as AnyObject)
        })
        form.setData(data: dataCommon)
        form.selected = { (indexpath, item) in
            guard let ite = item?.rawItem as? ModelOptionResponseProvincesCatalogDatum else {
                return
            }
            selected(ite)
        }
        form.show()
        form.titleLabel.text = "Chọn thành phố"
    }
    
    static func alertDistrist(selected: @escaping ((ModelOptionResponseDistrictsByProvinceCodeCatalogDatum) -> Void)) {
        let form = CustomFormViewController()
        form.isTypeCell = .ContentOnly
        var dataCommon:[CustomFormModelElement] = []
        dataCommon = Common.districtData.map({ (data) -> CustomFormModelElement in
            return CustomFormModelElement(selected: data.tenQuanHuyen, rawItem: data as AnyObject)
        })
        form.setData(data: dataCommon)
        form.selected = { (indexpath, item) in
            guard let ite = item?.rawItem as? ModelOptionResponseDistrictsByProvinceCodeCatalogDatum else {
                return
            }
            selected(ite)
        }
        form.show()
        form.titleLabel.text = "Chọn huyện"
    }
    
    static func alertJob(selected: @escaping ((ModelOptionResponseOccupationCatalogDatum) -> Void)) {
        let actionSheet = MyActionSheet(cancelButtonTitle: "Filter.Cancel".localize())
        for item in Common.jobData {
            actionSheet.add(MyActionSheetItem(title: item.tenNgheNghiep ?? "", handler: { _ in
                selected(item)
            }))
        }
        actionSheet.show()
    }
    
    static func alertReferral(selected: @escaping ((ModelOptionResponseReferralCatalogDatum) -> Void)) {
        let actionSheet = MyActionSheet(cancelButtonTitle: "Filter.Cancel".localize())
        for item in Common.referralData {
            actionSheet.add(MyActionSheetItem(title: item.nguonGioiThieu ?? "", handler: { _ in
                selected(item)
            }))
        }
        actionSheet.show()
    }
    
    static func alertTypeCustomer(selected: @escaping ((ModelOptionResponseCustomerTypeCatalogDatum) -> Void)) {
        let actionSheet = MyActionSheet(cancelButtonTitle: "Filter.Cancel".localize())
        for item in Common.typeCustomerData {
            actionSheet.add(MyActionSheetItem(title: item.loaiKhachHang ?? "", handler: { _ in
                selected(item)
            }))
        }
        actionSheet.show()
    }
    
    static func alertSourceTo(selected: @escaping ((ModelOptionResponseSourceToCatalogDatum) -> Void)) {
        let actionSheet = MyActionSheet(cancelButtonTitle: "Filter.Cancel".localize())
        for item in Common.sourceToData {
            actionSheet.add(MyActionSheetItem(title: item.tenNguonDen ?? "", handler: { _ in
                selected(item)
            }))
        }
        actionSheet.show()
    }
    
    static func alertDate(title: String, maximumDate: Date? = Date(), currentdate: Date? = Date(), selected: @escaping (String?) -> ()) {
        let pick:PresentedViewController = PresentedViewController()
        pick.maximumDate = maximumDate
        pick.titleString = title
        pick.buttonColor = AppColors.primaryColor
        pick.currentdate = currentdate
        pick.block = { (date) in
            selected(date)
        }
        UIApplication.topViewController()?.present(pick, animated: true, completion: nil)
    }
    
    static func alertTime(title: String, maximumDate: Date? = Date(), currentdate: Date? = Date(), selected: @escaping (String?) -> ()) {
        let pick:PresentedViewController = PresentedViewController()
        pick.pickerMode = .time
        pick.returnDateFormat = .h_mm
        pick.maximumDate = maximumDate
        pick.titleString = title
        pick.buttonColor = AppColors.primaryColor
        pick.currentdate = currentdate
        pick.block = { (date) in
            selected(date)
        }
        UIApplication.topViewController()?.present(pick, animated: true, completion: nil)
    }
    
    static func alertTimeHHmm(title: String, currentdate: Date? = Date(), selected: @escaping (String?) -> ()) {
        let pick:PresentedViewController = PresentedViewController()
        pick.pickerMode = .time
        pick.returnDateFormat = .h_mm
//        pick.maximumDate = maximumDate
        pick.titleString = title
        pick.buttonColor = AppColors.primaryColor
        pick.currentdate = currentdate
        pick.block = { (date) in
            selected(date)
        }
        UIApplication.topViewController()?.present(pick, animated: true, completion: nil)
    }
    
    static func alertStatusCatalog(isShowAll: Bool = false, selected: @escaping ((ModelOptionResponseStatusCatalogDatum) -> Void)) {
        let actionSheet = MyActionSheet(cancelButtonTitle: "Filter.Cancel".localize())
        var currentData = Common.typeStatusCatelogData
        if isShowAll == true {
            currentData = Common.addAllInTypeStatusCatelogData
        }
        for item in currentData {
            actionSheet.add(MyActionSheetItem(title: item.trangThai ?? "", handler: { _ in
                selected(item)
            }))
        }
        actionSheet.show()
    }
    
    static func alertInvoiceStatusCatalog(isShowAll: Bool = false, selected: @escaping ((ModelOptionResponseInvoiceStatusCatalogDatum) -> Void)) {
        let actionSheet = MyActionSheet(cancelButtonTitle: "Filter.Cancel".localize())
        var currentData = Common.typeInvoiceStatusCatelogData
        if isShowAll == true {
            currentData = Common.addAllInTypeInvoiceStatusCatelogData
        }
        for item in currentData {
            actionSheet.add(MyActionSheetItem(title: item.trangThai ?? "", handler: { _ in
                selected(item)
            }))
        }
        actionSheet.show()
    }
    
    static func alertTreatmentStatusCatalog(isShowAll: Bool = false, selected: @escaping ((ModelOptionResponseStatusCatalogDatum) -> Void)) {
        let actionSheet = MyActionSheet(cancelButtonTitle: "Filter.Cancel".localize())
        var currentData = Common.typeStatusTreatmentData
        if isShowAll == true {
            currentData = Common.addAllInStatusTreatmentData
        }
        for item in currentData {
            actionSheet.add(MyActionSheetItem(title: item.trangThai ?? "", handler: { _ in
                selected(item)
            }))
        }
        actionSheet.show()
    }
    
    static func alertTreatmentEditStatusCatalog(selected: @escaping ((ModelOptionResponseStatusCatalogDatum) -> Void)) {
        let actionSheet = MyActionSheet(cancelButtonTitle: "Filter.Cancel".localize())
        let currentData = Common.addAllInStatusTreatmentEditData
        
        for item in currentData {
            actionSheet.add(MyActionSheetItem(title: item.trangThai ?? "", handler: { _ in
                selected(item)
            }))
        }
        actionSheet.show()
    }
    
    
    static func alertRoomCatalog(selected: @escaping ((ModelOptionResponseAppointmentScheduleCatalogDatum) -> Void)) {
        let actionSheet = MyActionSheet(cancelButtonTitle: "Filter.Cancel".localize())
        for item in Common.roomCatalogData {
            actionSheet.add(MyActionSheetItem(title: item.tenPhongDichVu ?? "", handler: { _ in
                selected(item)
            }))
        }
        actionSheet.show()
    }
    
    static func alertPromotionCatalog(selected: @escaping ((PromotionProductOptionalResponse) -> Void)) {
        let actionSheet = MyActionSheet(cancelButtonTitle: "Filter.Cancel".localize())
        for item in Common.promotionCatalogData {
            actionSheet.add(MyActionSheetItem(title: item.tenChuongTrinhKM ?? "", handler: { _ in
                selected(item)
            }))
        }
        actionSheet.show()
    }
    
    
    static func alertUnitCatalog(selected: @escaping ((CheckProductOptionalResponse) -> Void)) {
        let actionSheet = MyActionSheet(cancelButtonTitle: "Filter.Cancel".localize())
        for (index,item) in Common.unitCatalogData.enumerated() {
            actionSheet.add(MyActionSheetItem(title: item.tenChoose ?? "", handler: { _ in
                selected(item)
            }))
        }
        actionSheet.show()
    }
    
    static func alertListDomain(selected: @escaping ((ServerSettingResponseDatum) -> Void)) {
        let actionSheet = MyActionSheet(cancelButtonTitle: "Filter.Cancel".localize())
        for (index,item) in Common.ListDomain.enumerated() {
            actionSheet.add(MyActionSheetItem(title: item.url ?? "", handler: { _ in
                selected(item)
            }))
        }
        actionSheet.show()
    }
    
    static func alertEmployeeAndSearchCatalog(isSelected: String,selected: @escaping (([ModelOptionResponseEmployeeAndSearchCatalogDatum]) -> Void)) {
        let form = CustomFormViewController()
        form.isTypeCell = .Member
        var dataCommon:[CustomFormModelElement] = []
        dataCommon = Common.employeeAndSearchCatalogData.map({ (data) -> CustomFormModelElement in
            var datass = CustomFormModelElement(selectedId: "\(data.idNhanVien ?? -1)", selected: data.tenNhanVien, rawItem: data as AnyObject)
            if isSelected.count > 0 {
                let arrayIdSelected = isSelected.split(separator: ",")
                for item in arrayIdSelected {
                    if item.contains("\(data.idNhanVien ?? -1)")  {
                        datass.isSelected = true
                        break
                    } else {
                        continue
                    }
                }
            }
            return datass
        })
        form.setData(data: dataCommon)
        form.selectedArray = { (items) in
            var dataItem:[ModelOptionResponseEmployeeAndSearchCatalogDatum] = []
            if let model = items {
                for item in model {
                    if item.isSelected == true {
                        if let modelForce = item.rawItem as? ModelOptionResponseEmployeeAndSearchCatalogDatum {
                            dataItem.append(modelForce)
                        }
                    }
                }
            }
            selected(dataItem)
        }
        form.show()
        form.titleLabel.text = "Chọn chuyên viên"
    }
    
    static func alertServiceCatalogData(isSelected: String,selected: @escaping (([ModelOptionResponseServiceCatalogDatum]) -> Void)) {
        let form = CustomFormViewController()
        form.isTypeCell = .Services
        var dataCommon:[CustomFormModelElement] = []
        dataCommon = Common.serviceCatalogData.map({ (data) -> CustomFormModelElement in
            var datass = CustomFormModelElement(selectedId: "\(data.idDichVu ?? -1)",selected: data.tenDichVu, rawItem: data as AnyObject)
            if isSelected.count > 0 {
                let arrayIdSelected = isSelected.split(separator: ",")
                for item in arrayIdSelected {
                    if item.contains("\(data.idDichVu ?? -1)")  {
                        datass.isSelected = true
                        break
                    } else {
                        continue
                    }
                }
            }
            
            return datass
        })
        form.setData(data: dataCommon)
        form.selectedArray = { (items) in
            var dataItem:[ModelOptionResponseServiceCatalogDatum] = []
            if let model = items {
                for item in model {
                    if item.isSelected == true {
                        if let modelForce = item.rawItem as? ModelOptionResponseServiceCatalogDatum {
                            dataItem.append(modelForce)
                        }
                    }
                }
            }
            selected(dataItem)
        }
        form.show()
        form.titleLabel.text = "Chọn dịch vụ"
    }
    
}

extension Date {
    func set18YearValidation() -> Date {
        let currentDate: Date = Date()
        var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        var components: DateComponents = DateComponents()
        components.calendar = calendar
        components.year = -18
        let maxDate: Date = calendar.date(byAdding: components, to: currentDate)!
        return maxDate
    }
}


extension UIImageView {
    func avartaImageView(url: String) {
        self.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "avarta_plain_holder"), options: SDWebImageOptions.delayPlaceholder, completed: nil)
    }
    func pictureSquareImageView(url: String) {
        self.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "image_square_plain_holder"), options: SDWebImageOptions.delayPlaceholder, completed: nil)
    }
    func pictureImageView(url: String) {
        self.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "image_plain_holder"), options: SDWebImageOptions.delayPlaceholder, completed: nil)
    }
    
    func pictureLogoImageView(url: String) {
        self.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "ic-logo-app"), options: SDWebImageOptions.delayPlaceholder, completed: nil)
    }
}

extension Int {
    func formatnumber() -> String {
        let formater = NumberFormatter()
        formater.groupingSeparator = ","
        formater.numberStyle = .decimal
        return formater.string(from: NSNumber(value: self))!
    }
    func formatnumberWithCurrency() -> String {
        let currency = "đ"
        let formater = NumberFormatter()
        formater.groupingSeparator = ","
        formater.numberStyle = .decimal
        return formater.string(from: NSNumber(value: self))! + currency
    }
}


extension Double {
    func formatnumber() -> String {
        let formater = NumberFormatter()
        formater.groupingSeparator = ","
        formater.numberStyle = .decimal
        return formater.string(from: NSNumber(value: self))!
    }
    func formatnumberWithCurrency() -> String {
        let currency = "đ"
        let formater = NumberFormatter()
        formater.groupingSeparator = ","
        formater.numberStyle = .decimal
        return formater.string(from: NSNumber(value: self))! + currency
    }
}


extension Date {
    var startDateOfMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    var endDateOfMonth: Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startDateOfMonth)!
    }
    
    func getFormattedDate(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "vi_VN")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension String {
    func setStringToDate(formatCurrent: String = "HH:mm dd/MM/yyyy") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "vi_VN")
        dateFormatter.dateFormat = formatCurrent
        guard let date = dateFormatter.date(from: self) else { return nil}
        return date
    }
}


extension UIControl {
    
    /// Typealias for UIControl closure.
    public typealias UIControlTargetClosure = (UIControl) -> ()
    
    private class UIControlClosureWrapper: NSObject {
        let closure: UIControlTargetClosure
        init(_ closure: @escaping UIControlTargetClosure) {
            self.closure = closure
        }
    }
    
    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }
    
    private var targetClosure: UIControlTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? UIControlClosureWrapper else { return nil }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, UIControlClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc func closureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure(self)
    }
    
    public func addAction(for event: UIControl.Event, closure: @escaping UIControlTargetClosure) {
        targetClosure = closure
        addTarget(self, action: #selector(UIControl.closureAction), for: event)
    }
    
}

extension UISearchBar {
    
    var textField: UITextField? {
        let subViews = subviews.flatMap { $0.subviews }
        return (subViews.filter { $0 is UITextField }).first as? UITextField
    }
}

extension UIViewController {
    func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
}

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
            value: NSUnderlineStyle.single.rawValue,
            range:NSMakeRange(0,attributeString.length))
        return attributeString
    }
}

extension String {
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
}

extension Array where Element: Equatable {
    func removingDuplicates() -> Array {
        return reduce(into: []) { result, element in
            if !result.contains(element) {
                result.append(element)
            }
        }
    }
}

public extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter{ seen.insert($0).inserted }
    }
}
extension UITextField {

    func fullTextWith(range: NSRange, replacementString: String) -> String? {

        if let fullSearchString = self.text, let swtRange = Range(range, in: fullSearchString) {

            return fullSearchString.replacingCharacters(in: swtRange, with: replacementString)
        }

        return nil
    }
}

extension UILabel{

    @IBInspectable private var autoAsterisk: Bool {
        get { return false }
        set {
            guard newValue else { return }
            DispatchQueue.main.async {
                self.setSubTextColor(pSubString: "*", pColor: .red)
            }
        }
    }
    func setSubTextColor(pSubString : String, pColor : UIColor){
        let textString = self.text ?? ""
        let attributedWithTextColor: NSAttributedString = textString.attributedStringWithColor([pSubString], color: pColor)
        self.attributedText = attributedWithTextColor

    }
   
}

extension String {
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }

        guard let characterSpacing = characterSpacing else {return attributedString}

        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))

        return attributedString
    }
}

extension String {
  
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]
            let attributedString = try NSMutableAttributedString(data: data, options: options, documentAttributes: nil)
            return attributedString
        } catch {
            return NSAttributedString()
        }
    }
    
    func customHTMLAttributedString(withFont font: UIFont?, textColor: UIColor) -> NSAttributedString? {
        guard let font = font else {
            return self.htmlToAttributedString
        }
        let hexCode = textColor.hexCodeString
        
        let css = "<style>body{font-family: '\(font.fontName)'; font-size:\(font.pointSize)px; color: \(hexCode);}</style>"
        
        let modifiedString = css + self
        return modifiedString.htmlToAttributedString
    }
  
}

extension UITextView {
    
    var htmlText: String? {
        set(value) {
            let newValue = value ?? ""

//            let htmlCSSString = "<head><style type=\"text/css\">" +
//                            "html *" +
//                            "{" +
//                            "line-height:1.5;" +
//                            "img{ max-height: 100%; max-width: \(self.frame.size.width) !important; width: 10; height: auto;}" +
//                            "}</style></head>" +
//                        "<body> \(newValue) <body>"
//            let htmlCSSString = "<head>" +
//                "   <style>" +
//            "        .responsive-container {" +
//            "        position: relative;" +
//            "        width: 100%;" +
//                    "border: 1px solid black;" +
//                    "overflow: hidden;" +
//                "}" +
//
//                ".dummy {" +
//                    "padding-top: 100%; /* forces 1:1 aspect ratio */" +
//                "}" +
//
//                ".img-container {" +
//                    "position: absolute;" +
//                    "top: 0;" +
//                    "bottom: 0;" +
//                    "left: 0;" +
//                    "right: 0;" +
//                    "display: flex;" +
//                    "justify-content: center; /* align horizontal */" +
//                    "align-items: center; /* align vertical */" +
//                "}</style></head>" +
//
//            "<div class=\\\"responsive-container\\\">" +
//                "<div class=\\\"dummy\\\"></div>" +
//                "<div class=\\\"img-container\\\">" +
//                    " \(newValue)" +
//                "</div></div>"



            
            let htmlCSSString = "<!DOCTYPE html><html><head>" +
                "   <style>" +
                "        html, body {width: \(self.frame.size.width-10); margin: 0;padding: 0;background-color: green;} !important" +
                "        img {width: \(self.frame.size.width-10); height: auto;} !important" +
                "   </style>" +
                "</head><body>" +
                newValue +
                "</body></html>"
            
            let encodedData = htmlCSSString.replace(string: "\\\"", replacement: "\"")
            print(encodedData)
            self.attributedText = htmlCSSString.customHTMLAttributedString(withFont: self.font, textColor: self.textColor ?? .black)
        }
        get {
            return self.attributedText.string
        }
    }
    
        func adjustUITextViewHeight() {
            
//            self.translatesAutoresizingMaskIntoConstraints = true
            self.sizeToFit()
            
            self.isScrollEnabled = false
        }
    
}

extension UIColor {
    
    var hexCodeString: String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

        return String(format:"#%06x", rgb)
    }
  
}
