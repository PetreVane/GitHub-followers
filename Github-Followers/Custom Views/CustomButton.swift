//
//  CustomButton.swift
//  Github-Followers
//
//  Created by Petre Vane on 03/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

/// Custom UIButton subclass
public class CustomButton: UIButton {

     //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Adds a customization for different buttons
    /// - Parameters:
    ///   - backgroundColor: your custom background color
    ///   - title: your custom title
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
     //MARK: - Configuration
    
    /// Sets custom corner radius & font for buttons
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)   //titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    
    /// Sets button color and title
    /// - Parameters:
    ///   - color: background color of button
    ///   - title: text shown on button
    func setButton(color: UIColor, title: String) {
        self.backgroundColor = color
        setTitle(title, for: .normal)
    }
}

