//
//  GFTextField.swift
//  Github-Followers
//
//  Created by Petre Vane on 03/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// Adds customization to TextField
    private func configure() {
        // autoLayout
        translatesAutoresizingMaskIntoConstraints = false
        
        // shape
        layer.cornerRadius = 10
        layer.borderWidth = 2
        
        // color
        layer.borderColor = UIColor.systemGray.cgColor
        textColor = .label // dark on white mode & white on dark mode
        
        //font
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        // background
        backgroundColor = .tertiarySystemBackground
        
        // placeholder & autocorrect
        autocorrectionType = .no
        placeholder = "Type a username"
        
    
    }
}
