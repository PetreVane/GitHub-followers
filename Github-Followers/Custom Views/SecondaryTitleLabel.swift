//
//  SecondaryTitleLabel.swift
//  Github-Followers
//
//  Created by Petre Vane on 25/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

/// Custom UILabel subclass
public class SecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        self.font = UIFont.monospacedSystemFont(ofSize: fontSize, weight: .medium)
    }
    
    
    /// Configures label's properties
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        backgroundColor = .secondaryLabel
    }
}
