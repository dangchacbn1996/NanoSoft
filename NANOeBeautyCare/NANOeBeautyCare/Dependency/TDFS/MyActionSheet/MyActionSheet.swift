//
//  MyActionSheet.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

public class MyActionSheet: UIView {
    
    /// MyActionSheet defaults, you can override it globally
    public struct Preferences {
        
        /// Height for buttons, defaults 56.0
        public static var ButtonHeight: CGFloat = 56.0
        
        public static var ButtonNormalBackgroundColor = UIColor(white: 1, alpha: 1)
        
        public static var ButtonHighlightBackgroundColor = UIColor(white: 248.0/255, alpha: 1)
        
        /// Title color for normal buttons, default to UIColor.black
        public static var ButtonTitleColor = UIColor.black
        
        /// Title color for destructive button, default to UIColor.red
        public static var DestructiveButtonTitleColor = UIColor.red
        
        /// Separator backgroundColor between CancelButton and other buttons
        public static var SeparatorColor = UIColor(white: 242.0/255, alpha: 1.0)
    }
    
    public var titleView: UIView?
    
    public var roundTopCorners: Bool = true
    
    private let containerView = UIView()
    private let backgroundView = UIView()
    private var items: [MyActionSheetItem] = []
    private let LineHeight: CGFloat = 1.0/UIScreen.main.scale
    private var cancelButtonTitle: String?
    
    public init(cancelButtonTitle: String? = nil) {
        let frame = UIScreen.main.bounds
        super.init(frame: frame)
        self.cancelButtonTitle = cancelButtonTitle
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public func show() {
        let windows = UIApplication.shared.windows.filter { NSStringFromClass($0.classForCoder) != "UIRemoteKeyboardWindow" }.reversed()
        guard let win = windows.first(where: { $0.isHidden == false }) else {
            return
        }
        buildUI()
        UIView.animate(withDuration: 0.1, animations: {
            win.addSubview(self)
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                self.backgroundView.alpha = 1.0
                let y = self.bounds.height - self.containerView.frame.height
                self.containerView.frame.origin = CGPoint(x: 0, y: y)
            }
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundView.alpha = 0.0
            let y = UIScreen.main.bounds.height
            self.containerView.frame.origin = CGPoint(x: 0, y: y)
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
    public func add(_ item: MyActionSheetItem) {
        items.append(item)
    }
}


// MARK: - Private Methods
extension MyActionSheet {
    
    private func commonInit() {
        backgroundView.frame = bounds
        backgroundView.alpha = 0.0
        backgroundView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        tapGesture.delegate = self
        backgroundView.addGestureRecognizer(tapGesture)
        addSubview(backgroundView)
        
        containerView.backgroundColor = .white
        addSubview(containerView)
    }
    
    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: backgroundView)
        if !containerView.frame.contains(point) {
            hide()
        }
    }
    
    private func buildUI() {
        
        var y: CGFloat = 0.0 // used to calculate container's height
        
        if let titleView = titleView {
            titleView.backgroundColor = Preferences.ButtonNormalBackgroundColor
            titleView.frame = CGRect(origin: .zero, size: CGSize(width: bounds.width, height: titleView.frame.height))
            containerView.addSubview(titleView)
            y = titleView.frame.height + LineHeight
        }
        
        if let cancelTitle = cancelButtonTitle, !items.contains(where: { $0.type == .cancel }) {
            items.append(MyActionSheetItem(title: cancelTitle, handler: nil, type: .cancel))
        }
        
        let highlightBackgroundImage = UIImage.imageWithColor(Preferences.ButtonHighlightBackgroundColor)
        let backgroundImage = UIImage.imageWithColor(Preferences.ButtonNormalBackgroundColor)
        
        let x = bounds.minX
        let width = bounds.width
        var height = Preferences.ButtonHeight
        
        for (index, item) in items.enumerated() {
            
            height = item.desc == nil ? Preferences.ButtonHeight: 62.0
            let isLastItem = index == items.count - 1
            let itemView = actionItemView(item: item, at: index, isLastItem: isLastItem, backgroundImage: backgroundImage, highlightBackgroundImage: highlightBackgroundImage)
            if isLastItem {
                if item.type == .cancel {
                    let separator = UIView(frame: CGRect(x: 0, y: y , width: width, height: 7.0))
                    separator.backgroundColor = Preferences.SeparatorColor
                    containerView.addSubview(separator)
                    y += separator.bounds.height
                }
                height = Preferences.ButtonHeight + safeInsets.bottom
            }
            
            itemView.frame = CGRect(x: x, y: y, width: width, height: height)
            containerView.addSubview(itemView)
            y += height
            
            if !isLastItem {
                let line = UIView()
                line.frame = CGRect(x: x, y: y, width: width, height: LineHeight)
                line.backgroundColor = UIColor(white: 0, alpha: 0.1)
                containerView.addSubview(line)
                y += LineHeight
            }
        }
        
        containerView.frame = CGRect(x: x, y: bounds.height, width: width, height: y)
        
        if roundTopCorners {
            
            containerView.layer.masksToBounds = true
            if #available(iOS 11.0, *) {
                containerView.layer.cornerRadius = 15
                containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            } else {
                // Fallback on earlier versions
                containerView.layer.roundCorners(corners: [.topLeft, .topRight], radius: 15)
            }
        }
        
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        effectView.frame = containerView.bounds
        containerView.addSubview(effectView)
        containerView.sendSubviewToBack(effectView)
    }
    
    fileprivate func actionItemView(item: MyActionSheetItem, at index: Int, isLastItem: Bool, backgroundImage: UIImage?, highlightBackgroundImage: UIImage?) -> UIView {
        
        if item.desc == nil {
            let button = UIButton(type: .custom)
            button.tag = index
            button.backgroundColor = .clear
            button.setBackgroundImage(backgroundImage, for: .normal)
            button.setBackgroundImage(highlightBackgroundImage, for: .highlighted)
            button.setTitle(item.title, for: .normal)
            button.setImage(item.iconImage, for: .normal)
            button.imageEdgeInsets = item.imageEdgeInsets
            button.titleEdgeInsets = isLastItem ? UIEdgeInsets(top: -safeInsets.bottom/2, left: 0, bottom: safeInsets.bottom/2, right: 0) : item.titleEdgeInsets
            button.titleLabel?.font = item.font
            let titleColor = item.type == .destructive ? Preferences.DestructiveButtonTitleColor: item.titleColor
            button.setTitleColor(titleColor, for: .normal)
            button.addTarget(self, action: #selector(handleButtonTapped(_:)), for: .touchUpInside)
            return button
        } else {
            let view = UIView()
            
            let button = UIButton()
            button.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 62)
            button.tag = index
            button.addTarget(self, action: #selector(handleButtonTapped(_:)), for: .touchUpInside)
            button.setBackgroundImage(backgroundImage, for: .normal)
            button.setBackgroundImage(highlightBackgroundImage, for: .highlighted)
            
            let titleLabel = UILabel()
            titleLabel.textAlignment = .center
            titleLabel.text = item.title
            titleLabel.textColor = item.titleColor
            titleLabel.font = UIFont.systemFont(ofSize: 18)
            titleLabel.frame = CGRect(x: 0, y: 12, width: bounds.width, height: 22)
            
            let descLabel = UILabel()
            descLabel.textAlignment = .center
            descLabel.text = item.desc
            descLabel.textColor = item.descColor
            descLabel.font = UIFont.systemFont(ofSize: 12)
            descLabel.frame = CGRect(x: 0, y: 36, width: bounds.width, height: 15)
            
            view.addSubview(button)
            view.addSubview(titleLabel)
            view.addSubview(descLabel)
            return view
        }
    }
    
    fileprivate var safeInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets ?? .zero
        } else {
            // Fallback on earlier versions
            return .zero
        }
    }
    
    @objc private func handleButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        
        hide()
        
        let item = items[index]
        item.handler?(self)
    }
}

// MARK: - UIGestureRecognizerDelegate
extension MyActionSheet: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == self.containerView {
            return false
        }
        return true
    }
}

fileprivate extension UIImage {
    
    class func imageWithColor(_ color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}

extension CALayer {
  func roundCorners(corners: UIRectCorner, radius: CGFloat) {
    let maskPath = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))

    let shape = CAShapeLayer()
    shape.path = maskPath.cgPath
    mask = shape
  }
}
