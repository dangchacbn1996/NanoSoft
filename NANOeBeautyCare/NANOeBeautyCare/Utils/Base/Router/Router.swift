//
//  Router.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

class Router {
    
    let currentController: UIViewController
    
    init(viewController: UIViewController) {
        self.currentController = viewController
    }
    
    func setRootScreen(_ screen: Screen,
                       isUseRootNavigation: Bool,
                       fromStoryboard storyboard: Storyboard,
                       withContext context: RouteContext? = nil) {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: screen.rawValue)
        if var nextRoutableScreen = nextViewController as? RoutableScreen {
            nextRoutableScreen.context = context
        }
        if isUseRootNavigation == true {
            let navigationController = UINavigationController(rootViewController: nextViewController)
            UIApplication.shared.keyWindow?.rootViewController = navigationController
        } else {
            UIApplication.shared.keyWindow?.rootViewController = nextViewController
        }
    }
    
    func setRootScreen(_ viewController: UIViewController,
                       isUseRootNavigation: Bool,
                       withContext context: RouteContext? = nil) {
//        let nextViewController = storyboard.instantiateViewController(withIdentifier: screen.rawValue)
        if var nextRoutableScreen = viewController as? RoutableScreen {
            nextRoutableScreen.context = context
        }
        if isUseRootNavigation == true {
            let navigationController = UINavigationController(rootViewController: viewController)
            UIApplication.shared.keyWindow?.rootViewController = navigationController
        } else {
            UIApplication.shared.keyWindow?.rootViewController = viewController
        }
    }
    
    func openScreen(_ screen: Screen,
                    fromStoryboard storyboard: Storyboard,
                    isChildScreen: Bool,
                    withContext context: RouteContext? = nil) {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: screen.rawValue)
        
        if var nextRoutableScreen = nextViewController as? RoutableScreen {
            nextRoutableScreen.context = context
        }
        if isChildScreen {
            currentController.navigationController?
                .pushViewController(nextViewController, animated: true)
        } else {
            let navController = UINavigationController(rootViewController: nextViewController)
            currentController.presentInFullScreen(navController, animated: true, completion: nil)
        }
    }
    
    func openScreen(_ screen: UIViewController,
                    isChildScreen: Bool,
                    withContext context: RouteContext? = nil) {
        let nextViewController = screen
        
        if var nextRoutableScreen = nextViewController as? RoutableScreen {
            nextRoutableScreen.context = context
        }
        if isChildScreen {
            currentController.navigationController?
                .pushViewController(nextViewController, animated: true)
        } else {
            let navController = UINavigationController(rootViewController: nextViewController)
            currentController.presentInFullScreen(navController, animated: true, completion: nil)
        }
    }
    
    func panScren(_ screen: Screen,
                  fromStoryboard storyboard: Storyboard,
                  withContext context: RouteContext? = nil) {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: screen.rawValue)
        if var nextRoutableScreen = nextViewController as? RoutableScreen {
            nextRoutableScreen.context = context
        }
        if let vc = nextViewController as? UIViewController & PanModalPresentable {
            if UIDevice.current.userInterfaceIdiom == .pad {
                //                let sourceRect = vc.view.bounds
                //                let sourceView = vc.view
                //                vc.delegate = currentController
                currentController.presentPanModal(vc)
            } else {
                currentController.presentPanModal(vc)
            }
        } else {
            currentController.navigationController?
                .pushViewController(nextViewController, animated: true)
        }
    }
    
    func panDismissScreen(with context: RouteContext? = nil) {
        currentController.dismiss(animated: true) {
            if var prevRoutableController = UIApplication.topViewController() as? RoutableScreen {
                if let data = context {
                    prevRoutableController.updatePanData(context: data)
                }
            }
        }
    }
    
    
    func openViewController(_ nextViewController:UIViewController,
                            isChildScreen: Bool,
                            withContext context: RouteContext? = nil) {
        if var nextRoutableScreen = nextViewController as? RoutableScreen {
            nextRoutableScreen.context = context
        }
        if isChildScreen {
            let navigationController = UINavigationController(rootViewController: nextViewController)
            UIApplication.shared.keyWindow?.rootViewController = navigationController
        } else {
            currentController.present(nextViewController, animated: true, completion: nil)
        }
    }
    
    func backToPrevScreen(with context: RouteContext? = nil) {
        if let stackScreensCount = currentController.navigationController?.viewControllers.count, var prevRoutableController = currentController.navigationController?.viewControllers[stackScreensCount-2] as? RoutableScreen {
            prevRoutableController.context = context
            if let data = context {
                prevRoutableController.updatePanData(context: data)
            }
        }
        
        currentController.navigationController?
            .popViewController(animated: true)
    }
    
    func backToPrevToVC(with vc: UIViewController.Type, context: RouteContext? = nil) {
        if let viewcontrollers = currentController.navigationController?.viewControllers {
            var indexCurrent = -1
            for (index,item) in viewcontrollers.enumerated() {
                if item.isKind(of: vc.self) {
                    indexCurrent = index
                    break
                }
            }
            if indexCurrent != -1 {
                currentController.navigationController?.viewControllers.removeSubrange(indexCurrent+1..<viewcontrollers.count-1)
            }
        }
        var prevRoutableController = currentController.navigationController?.viewControllers.last as? RoutableScreen
        prevRoutableController?.context = context
        if let viewcontrollers = currentController.navigationController?.viewControllers {
            currentController.navigationController?.setViewControllers(viewcontrollers, animated: true)
        }
        currentController.navigationController?
        .popViewController(animated: true)
    }
    
    func setIconLeftNavigation() {
        currentController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Quay về", style: .plain, target: nil, action: nil)
    }
    
    func setIconRightNavigation(listButton: [UIBarButtonItem] = []) {
        var listWithSpace : [UIBarButtonItem] = []
        let space: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: currentController.self, action: nil)
        for (index,item) in listButton.enumerated() {
            listWithSpace.append(item)
            if index == (listButton.count-1) {
                
            } else {
                listWithSpace.append(space)
            }
        }
        
        currentController.navigationItem.rightBarButtonItems = listWithSpace
    }
}

extension UIViewController {
    func removeFromNavigationController() { navigationController?.removeController(.last) { self == $0 } }
}

extension UINavigationController {
    enum ViewControllerPosition { case first, last }
    enum ViewControllersGroupPosition { case first, last, all }
    
    func removeController(_ position: ViewControllerPosition, animated: Bool = true,
                          where closure: (UIViewController) -> Bool) {
        var index: Int?
        switch position {
        case .first: index = viewControllers.firstIndex(where: closure)
        case .last: index = viewControllers.lastIndex(where: closure)
        }
        if let index = index { removeControllers(animated: animated, in: Range(index...index)) }
    }
    
    func removeControllers(_ position: ViewControllersGroupPosition, animated: Bool = true,
                           where closure: (UIViewController) -> Bool) {
        var range: Range<Int>?
        switch position {
        case .first: range = viewControllers.firstRange(where: closure)
        case .last:
            guard let _range = viewControllers.reversed().firstRange(where: closure) else { return }
            let count = viewControllers.count - 1
            range = .init(uncheckedBounds: (lower: count - _range.min()!, upper: count - _range.max()!))
        case .all:
            let viewControllers = self.viewControllers.filter { !closure($0) }
            setViewControllers(viewControllers, animated: animated)
            return
        }
        if let range = range { removeControllers(animated: animated, in: range) }
    }
    
    func removeControllers(animated: Bool = true, in range: Range<Int>) {
        var viewControllers = self.viewControllers
        viewControllers.removeSubrange(range)
        setViewControllers(viewControllers, animated: animated)
    }
    
    func removeControllers(animated: Bool = true, in range: ClosedRange<Int>) {
        removeControllers(animated: animated, in: Range(range))
    }
}

private extension Array {
    func firstRange(where closure: (Element) -> Bool) -> Range<Int>? {
        guard var index = firstIndex(where: closure) else { return nil }
        var indexes = [Int]()
        while index < count && closure(self[index]) {
            indexes.append(index)
            index += 1
        }
        if indexes.isEmpty { return nil }
        return Range<Int>(indexes.min()!...indexes.max()!)
    }
}


extension UINavigationController {
    func removeControllers(between start: UIViewController?, end: UIViewController?) {
        guard viewControllers.count > 1 else { return }
        let startIndex: Int
        if let start = start {
            guard let index = viewControllers.index(of: start) else {
                return
            }
            startIndex = index
        } else {
            startIndex = 0
        }
        
        let endIndex: Int
        if let end = end {
            guard let index = viewControllers.index(of: end) else {
                return
            }
            endIndex = index
        } else {
            endIndex = viewControllers.count - 1
        }
        let range = startIndex + 1 ..< endIndex
        viewControllers.removeSubrange(range)
    }
}
