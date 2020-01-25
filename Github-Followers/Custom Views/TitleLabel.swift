//
//  TitleLabel.swift
//  Github-Followers
//
//  Created by Petre Vane on 08/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

class TitleLabel: UILabel {

     //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
    }
    
     //MARK: - Configuration
    
    private func configure() {
        // autoLayout
        translatesAutoresizingMaskIntoConstraints = false
        
        // text attributes
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        numberOfLines = 1
        
        // visual attributes
        layer.cornerRadius = 10
        backgroundColor = UIColor.systemBackground
        
    }
}

