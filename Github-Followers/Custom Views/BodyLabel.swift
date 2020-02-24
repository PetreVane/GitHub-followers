//
//  BodyLabel.swift
//  Github-Followers
//
//  Created by Petre Vane on 08/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

/// Custom UILabel subclass
class BodyLabel: UILabel {
    
     //MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }
    
     //MARK: - Configuration
    
    private func configure() {
        //autoLayout
        translatesAutoresizingMaskIntoConstraints = false
        
        // text attributes
        textColor = .secondaryLabel
        font = UIFont.systemFont(ofSize: 15)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
    }
}
