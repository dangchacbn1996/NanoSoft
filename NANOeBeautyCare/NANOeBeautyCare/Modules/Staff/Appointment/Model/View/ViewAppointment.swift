//
//  ViewAppointment.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/8/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

struct HeaderCellDataViewAppointment {
    var title: String
}

struct FotterCellDataViewAppointment {

}
class ViewAppointment: HeaderFooterModelProvider {
    typealias CellModelType = CellViewAppointment
    typealias HeaderModelType = HeaderCellDataViewAppointment
    typealias FooterModelType = Any

    var headerProperty: (identifier: String?, height: CGFloat?, model: HeaderCellDataViewAppointment?)?
    var items: [CellViewAppointment]?
    var footerProperty: (identifier: String?, height: CGFloat?, model: Any?)?

    required init(_ _header: (identifier: String?, height: CGFloat?, model: HeaderCellDataViewAppointment?)?, _ _footer: (identifier: String?, height: CGFloat?, model: Any?)?, _ _items: [CellViewAppointment]?) {
        headerProperty = _header
        items = _items
        footerProperty = _footer
    }
}

struct CellViewAppointment: CellModelProvider {
    typealias CellModelType = AppointmentOptionalResponse
    var property: (identifier: String, height: CGFloat?, model: AppointmentOptionalResponse?)?

    init(_ _property: (identifier: String, height: CGFloat?, model: AppointmentOptionalResponse?)?) {
        property = _property
    }
}
