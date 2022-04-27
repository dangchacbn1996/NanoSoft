//
//  HospitalMainDatasource.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 17/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

import UIKit

//ViewCustomerHome
class ViewHospitalMain: HeaderFooterModelProvider {
    typealias CellModelType = CellViewHospitalMain
    typealias HeaderModelType = Any
    typealias FooterModelType = Any

    var headerProperty: (identifier: String?, height: CGFloat?, model: Any?)?
    var items: [CellViewHospitalMain]?
    var footerProperty: (identifier: String?, height: CGFloat?, model: Any?)?

    required init(_ _header: (identifier: String?, height: CGFloat?, model: Any?)?, _ _footer: (identifier: String?, height: CGFloat?, model: Any?)?, _ _items: [CellViewHospitalMain]?) {
        headerProperty = _header
        items = _items
        footerProperty = _footer
    }
}

//CellViewCustomerHome
struct CellViewHospitalMain: CellModelProvider {
    typealias CellModelType = CellDataHospitalMain
    var property: (identifier: String, height: CGFloat?, model: CellDataHospitalMain?)?

    init(_ _property: (identifier: String, height: CGFloat?, model: CellDataHospitalMain?)?) {
        property = _property
    }
}

//EnumTypeCellDataCustomerHome
enum EnumTypeCellDataHospitalMain: Int {
    case Introduce = 0
    case DoctorByMajor = 1
    case Function = 2
    case Service = 3
    case News = 4
}

//CellDataCustomerHome
struct CellDataHospitalMain {
    var type: EnumTypeCellDataHospitalMain?
    var newCustomer: [NewCustomerHomeOptionalResponse]?
    var majorHospital: [ResponseMajorModel]?
    var doctorByMajor: [ResponseDoctorByMajorModel]?
    var serviceHospital: [ResponseComboServiceModel]?
    var suggestionCustomer: [ResponseProductModel]?
//    var agencyCustomer: [AgencyCustomerHomeOptionalResponse]?
}
