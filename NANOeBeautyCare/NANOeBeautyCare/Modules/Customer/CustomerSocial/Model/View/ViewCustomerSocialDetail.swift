//
//  ViewCustomerSocialDetail.swift
//  NANOeBeautyCare
//
//  Created by Dom on 11/10/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class ViewCustomerSocialDetail: HeaderFooterModelProvider {
    typealias CellModelType = CellViewCustomerSocialDetail
    typealias HeaderModelType = Any
    typealias FooterModelType = Any

    var headerProperty: (identifier: String?, height: CGFloat?, model: Any?)?
    var items: [CellViewCustomerSocialDetail]?
    var footerProperty: (identifier: String?, height: CGFloat?, model: Any?)?

    required init(_ _header: (identifier: String?, height: CGFloat?, model: Any?)?, _ _footer: (identifier: String?, height: CGFloat?, model: Any?)?, _ _items: [CellViewCustomerSocialDetail]?) {
        headerProperty = _header
        items = _items
        footerProperty = _footer
    }
}

struct CellViewCustomerSocialDetail: CellModelProvider {
    typealias CellModelType = CustomerSocialDetailTableViewCell
    var property: (identifier: String, height: CGFloat?, model: CustomerSocialDetailTableViewCell?)?

    init(_ _property: (identifier: String, height: CGFloat?, model: CustomerSocialDetailTableViewCell?)?) {
        property = _property
    }
}
