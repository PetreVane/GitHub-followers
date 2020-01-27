//
//  UIView+constraints.swift
//  Github-Followers
//
//  Created by Petre Vane on 25/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit



extension UIView {
    
    /// Adds constraints to the calling object
    /// - Parameters:
    ///   - top: top constraint on Y axis
    ///   - left: leading constraint on X axis
    ///   - right: trailing constraint on X axis
    ///   - bottom: bottom constraint on Y axis
    ///   - topPadding: CGFloat value representing distance between this object and the above margin or existing object
    ///   - leftPadding: CGFloat value representing distance between this object and the leading margin or existing object
    ///   - rightPadding: CGFloat value representing distance between this object and the trailing margin or existing object
    ///   - bottomPadding: CGFloat value representing distance between this object and the bottom margin or existing object
    ///   - height: CGFloat value representing the height of the object
    ///   - width: CGFloat value representing the width of the object

    func setConstraints(top: NSLayoutYAxisAnchor? = nil, topPadding: CGFloat? = nil, left: NSLayoutXAxisAnchor? = nil, leftPadding: CGFloat? = nil, right: NSLayoutXAxisAnchor? = nil, rightPadding: CGFloat? = nil, bottom: NSLayoutYAxisAnchor? = nil, bottomPadding: CGFloat? = nil, height: CGFloat? = nil, width: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: topPadding ?? 0).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: leftPadding ?? 0).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: rightPadding ?? 0).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: bottomPadding ?? 0).isActive = true
        }
        
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
    }
    
}
