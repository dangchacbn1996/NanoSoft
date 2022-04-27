//
//  JNSegmentedControlCollectionViewCellRepresentable.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//


import UIKit

/// JNSegmentedControlCollectionViewCellRepresentable
class JNSegmentedControlCollectionViewCellRepresentable {
    
    /// Attributed String
    private(set) var attributedString: NSAttributedString
    
    /// Options
    private(set) var options: JNSegmentedCollectionOptions
    
    /// Is Last Item
    private(set) var isLastItem: Bool
    
    /// Is Selected
    private(set) var isSelected: Bool = false
    
    /// Cell Size
    private(set) var cellSize: CGSize
    
    /**
     Initializer
     */
    init() {
        
        // Set default values
        self.attributedString = NSAttributedString()
        self.options = JNSegmentedCollectionOptions()
        self.isLastItem = false
        self.isSelected = false
        self.cellSize = CGSize.zero
    }
    
    /**
     Initialize
     */
    convenience init(attributedString: NSAttributedString, options: JNSegmentedCollectionOptions, isLastItem: Bool = false, isSelected: Bool = false, cellSize: CGSize = CGSize.zero) {
        self.init()
        
        // build representable
        self.attributedString = attributedString
        self.options = options
        self.isLastItem = isLastItem
        self.isSelected = isSelected
        self.cellSize = cellSize
    }
    
    /**
     Set Is Selected
     - Parameter isSelected: Is Selected Value
     */
    func setIsSelected(_ isSelected: Bool) {
        
        // Set Is Selected
        self.isSelected = isSelected
    }
    
    /**
     Update Cell Size
     - Parameter isSelected: Is Selected Value
     */
    func updateCellSize(_ newSize: CGSize) {
        self.cellSize = newSize
    }
}
