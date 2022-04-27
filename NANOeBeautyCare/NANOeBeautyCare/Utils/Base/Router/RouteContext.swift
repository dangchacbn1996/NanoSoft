//
//  RouteContext.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

let RVContext:String = "RViewContext"
let RVBackContext:String = "RViewContext"
let RVIsReload:String = "RVIsReload"

protocol RoutableScreen {
    var context: RouteContext? { get set }
    func updatePanData(context:RouteContext)
}

struct RouteContext {
    private let params: [String: Any]
    
    subscript<T>(key: String ) -> T? {
        return params[key] as? T
    }
    
    func getData(key: String) -> Any {
        return params[key]
    }
    
    init(_ params: [String: Any]) {
        self.params = params
    }
}

