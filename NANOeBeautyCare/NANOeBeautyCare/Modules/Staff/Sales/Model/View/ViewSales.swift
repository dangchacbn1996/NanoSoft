//
//  ViewSales.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/8/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class ViewSales: HeaderFooterModelProvider {
    typealias CellModelType = CellViewSales
    typealias HeaderModelType = HeaderCellDataViewAppointment
    typealias FooterModelType = Any

    var headerProperty: (identifier: String?, height: CGFloat?, model: HeaderCellDataViewAppointment?)?
    var items: [CellViewSales]?
    var footerProperty: (identifier: String?, height: CGFloat?, model: Any?)?

    required init(_ _header: (identifier: String?, height: CGFloat?, model: HeaderCellDataViewAppointment?)?, _ _footer: (identifier: String?, height: CGFloat?, model: Any?)?, _ _items: [CellViewSales]?) {
        headerProperty = _header
        items = _items
        footerProperty = _footer
    }
}

struct CellViewSales: CellModelProvider {
    typealias CellModelType = SalesOptionalResponse
    var property: (identifier: String, height: CGFloat?, model: SalesOptionalResponse?)?

    init(_ _property: (identifier: String, height: CGFloat?, model: SalesOptionalResponse?)?) {
        property = _property
    }
}
