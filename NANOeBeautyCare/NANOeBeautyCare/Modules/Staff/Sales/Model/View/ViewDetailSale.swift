//
//  ViewDetailSale.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/30/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class ViewDetailSale: HeaderFooterModelProvider {
    typealias CellModelType = CellViewSales
    typealias HeaderModelType = Any
    typealias FooterModelType = Any

    var headerProperty: (identifier: String?, height: CGFloat?, model: Any?)?
    var items: [CellViewSales]?
    var footerProperty: (identifier: String?, height: CGFloat?, model: Any?)?

    required init(_ _header: (identifier: String?, height: CGFloat?, model: Any?)?, _ _footer: (identifier: String?, height: CGFloat?, model: Any?)?, _ _items: [CellViewSales]?) {
        headerProperty = _header
        items = _items
        footerProperty = _footer
    }
}

struct CellViewDetailSales: CellModelProvider {
    typealias CellModelType = SalesOptionalResponse
    var property: (identifier: String, height: CGFloat?, model: SalesOptionalResponse?)?

    init(_ _property: (identifier: String, height: CGFloat?, model: SalesOptionalResponse?)?) {
        property = _property
    }
}
