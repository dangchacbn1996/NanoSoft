//
//  ViewCustomerHomeNews.swift
//  NANOeBeautyCare
//
//  Created by Dom on 10/10/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class ViewCustomerHomeNews: HeaderFooterModelProvider {
    typealias CellModelType = CellViewCustomerHomeNews
    typealias HeaderModelType = Any
    typealias FooterModelType = Any

    var headerProperty: (identifier: String?, height: CGFloat?, model: Any?)?
    var items: [CellViewCustomerHomeNews]?
    var footerProperty: (identifier: String?, height: CGFloat?, model: Any?)?

    required init(_ _header: (identifier: String?, height: CGFloat?, model: Any?)?, _ _footer: (identifier: String?, height: CGFloat?, model: Any?)?, _ _items: [CellViewCustomerHomeNews]?) {
        headerProperty = _header
        items = _items
        footerProperty = _footer
    }
}

struct CellViewCustomerHomeNews: CellModelProvider {
    typealias CellModelType = CellDataCustomerHomeNews
    var property: (identifier: String, height: CGFloat?, model: CellDataCustomerHomeNews?)?

    init(_ _property: (identifier: String, height: CGFloat?, model: CellDataCustomerHomeNews?)?) {
        property = _property
    }
}
struct CellDataCustomerHomeNews {
    var model: CustomerHomeNewsOptionalResponse?
    var newsRe: DanhSachTinTucLienQuan?
}
