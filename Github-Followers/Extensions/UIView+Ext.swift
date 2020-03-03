//
//  UIView+Ext.swift
//  Github-Followers
//
//  Created by Petre Vane on 03/03/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Pins calling object to its superView
    /// - Parameter view: view that needs to be pinned to its superView
    func pinToEdgesOf(superView view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
           topAnchor.constraint(equalTo: view.topAnchor),
           leadingAnchor.constraint(equalTo: view.leadingAnchor),
           trailingAnchor.constraint(equalTo: view.trailingAnchor),
           bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    /// Wrapper around addSubview method
    /// - Parameter views: variadic parameter of type UIView
    ///
    /// - accepts variadic paramaters, iterates over them and calls addSubview on each of them.
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
