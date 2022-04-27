//
//  BaseView.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

protocol BaseView {
    func setRootScreen(_ screen: Screen,
                       isUseRootNavigation: Bool,
                       fromStoryboard storyboard: Storyboard,
                       withContext context: RouteContext?)
    
    func setRootScreen(_ viewController: UIViewController,
                       isUseRootNavigation: Bool,
                       withContext context: RouteContext?)
    
    func openScreen(_ screen: Screen,
                    fromStoryboard storyboard: Storyboard,
                    withContext context: RouteContext?)
    
    func openChildScreen(_ screen: Screen,
                         fromStoryboard storyboard: Storyboard,
                         withContext context: RouteContext?)
    func panScreen(_ screen: Screen,
                   fromStoryboard storyboard: Storyboard,
                   withContext context: RouteContext?)
    func openViewController(_ nextViewController:UIViewController,
                            isChildScreen: Bool,
                            withContext context: RouteContext?)
    
    func backToPrevScreen(with context: RouteContext?)
    func panDismissScreen(with context: RouteContext?)
    func setIconLeftNavigation(with context: RouteContext?)
    func setIconRightNavigation(with listButton: [UIBarButtonItem]?)
    func backToPrevToVC(with vc: UIViewController.Type, context: RouteContext?)
}
