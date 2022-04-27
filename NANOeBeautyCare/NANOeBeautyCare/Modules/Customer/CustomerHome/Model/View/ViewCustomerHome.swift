//
//  ViewCustomerHome.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/22/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class ViewCustomerHome: HeaderFooterModelProvider {
    typealias CellModelType = CellViewCustomerHome
    typealias HeaderModelType = Any
    typealias FooterModelType = Any

    var headerProperty: (identifier: String?, height: CGFloat?, model: Any?)?
    var items: [CellViewCustomerHome]?
    var footerProperty: (identifier: String?, height: CGFloat?, model: Any?)?

    required init(_ _header: (identifier: String?, height: CGFloat?, model: Any?)?, _ _footer: (identifier: String?, height: CGFloat?, model: Any?)?, _ _items: [CellViewCustomerHome]?) {
        headerProperty = _header
        items = _items
        footerProperty = _footer
    }
}

struct CellViewCustomerHome: CellModelProvider {
    typealias CellModelType = CellDataCustomerHome
    var property: (identifier: String, height: CGFloat?, model: CellDataCustomerHome?)?

    init(_ _property: (identifier: String, height: CGFloat?, model: CellDataCustomerHome?)?) {
        property = _property
    }
}

enum EnumTypeCellDataCustomerHome: Int {
    case Suggestion = 0
    case News = 1
    case Agency = 2
}

struct CellDataCustomerHome {
    var type: EnumTypeCellDataCustomerHome?
    var newCustomer: [NewCustomerHomeOptionalResponse]?
    var majorHospital: [ResponseMajorModel]?
    var suggestionCustomer: [SuggestionCustomerHomeOptionalResponse]?
    var agencyCustomer: [AgencyCustomerHomeOptionalResponse]?
    
    init(type: EnumTypeCellDataCustomerHome?, newCustomer: [NewCustomerHomeOptionalResponse]?, suggestionCustomer: [SuggestionCustomerHomeOptionalResponse]?, agencyCustomer: [AgencyCustomerHomeOptionalResponse]?) {
        self.type = type
        self.newCustomer = newCustomer
        self.majorHospital = nil
        self.suggestionCustomer = suggestionCustomer
        self.agencyCustomer = agencyCustomer
    }
    
    init(type: EnumTypeCellDataCustomerHome?, newCustomer: [NewCustomerHomeOptionalResponse]?, majorHospital: [ResponseMajorModel]?, suggestionCustomer: [SuggestionCustomerHomeOptionalResponse]?, agencyCustomer: [AgencyCustomerHomeOptionalResponse]?) {
        self.type = type
        self.newCustomer = newCustomer
        self.majorHospital = majorHospital
        self.suggestionCustomer = suggestionCustomer
        self.agencyCustomer = agencyCustomer
    }
}
