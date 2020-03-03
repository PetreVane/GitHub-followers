//
//  TextField.swift
//  Github-Followers
//
//  Created by Petre Vane on 03/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

/// Custom UITextField subclass
class TextField: UITextField {

     //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     //MARK: - Configuration
    
    /// Adds customization to TextField
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        // shape
        layer.cornerRadius = 10
        layer.borderWidth = 2
        
        // color
        layer.borderColor = UIColor.systemGray4.cgColor
        textColor = .label // dark on white mode & white on dark mode
        tintColor = .label
        
        //text allignment
        textAlignment = .center
        clearButtonMode = .whileEditing
        
        //font
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        // background
        backgroundColor = .tertiarySystemBackground
        
        // placeholder & autocorrect
        autocorrectionType = .no
        placeholder = "Type a username"
        
        //custom return button on keyboard
        keyboardType = .default
        returnKeyType = .go
    }
}
