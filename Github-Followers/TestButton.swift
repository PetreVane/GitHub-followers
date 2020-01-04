//
//  TestButton.swift
//  Github-Followers
//
//  Created by Petre Vane on 04/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

class TestButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        
        
        // using autoLayut
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}


class TestTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        layer.cornerRadius = 10
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 2
        
        textColor = .label
        placeholder = "Type something here"
        textColor = UIColor.gray
        borderStyle = .roundedRect
        
    }
}
