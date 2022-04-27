//
//  UIViewController+Ext.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

extension UIViewController {
    func add(childViewController: UIViewController) {
        self.addChild(childViewController)
        self.view.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)
    }
    
    func insert(childViewController: UIViewController, belowSubview subview: UIView) {
        self.addChild(childViewController)
        self.view.insertSubview(childViewController.view, belowSubview: subview)
        childViewController.didMove(toParent: self)
    }
    
    func insert(childViewController: UIViewController, aboveSubview subview: UIView) {
        self.addChild(childViewController)
        self.view.insertSubview(childViewController.view, aboveSubview: subview)
        childViewController.didMove(toParent: self)
    }
    
    func insert(childViewController: UIViewController, at index: Int) {
        self.addChild(childViewController)
        self.view.insertSubview(childViewController.view, at: index)
        childViewController.didMove(toParent: self)
    }
    
    func removeFromeParent() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
}

extension UIViewController {
    
    private class func instantiateControllerInStoryboard<T: UIViewController>(_ storyboard: UIStoryboard, identifier: String) -> T {
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
    
    class func controllerInStoryboard(_ storyboard: UIStoryboard, identifier: String) -> Self {
        return instantiateControllerInStoryboard(storyboard, identifier: identifier)
    }
    
    class func controllerInStoryboard(_ storyboard: UIStoryboard) -> Self {
        return controllerInStoryboard(storyboard, identifier: nameOfClass)
    }
    
    class func controllerFromStoryboard(_ storyboard: Storyboards) -> Self {
        return controllerInStoryboard(UIStoryboard(name: storyboard.rawValue, bundle: nil), identifier: nameOfClass)
    }
    
    class func controllerFromStoryboard(_ storyboardName: String) -> Self {
        return controllerInStoryboard(UIStoryboard(name: storyboardName, bundle: nil), identifier: nameOfClass)
    }
}

extension UIViewController {
    func presentInFullScreen(_ viewController: UIViewController,
                             animated: Bool,
                             completion: (() -> Void)? = nil) {
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: animated, completion: completion)
    }
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        
        return instantiateFromNib()
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
