//
//  GFButton.swift
//  Github-Followers
//
//  Created by Petre Vane on 03/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // adding customisation
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Adds a customization for different buttons
    /// - Parameters:
    ///   - backgroundColor: your custom background color
    ///   - title: your custom title
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        
        //adding customisation
        configure() 
    }
    
    
    /// Sets custom corner radius & font for buttons
    private func configure() {
        
        // shape
        layer.cornerRadius = 10
        
        // color
        titleLabel?.textColor = .white
        
        //font
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        
        // autoLayout
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
