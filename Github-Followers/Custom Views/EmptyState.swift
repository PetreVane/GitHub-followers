//
//  EmptyState.swift
//  Github-Followers
//
//  Created by Petre Vane on 20/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

/// View shown when a user has no Followers
class EmptyState: UIView {

    let messageLabel =  TitleLabel(textAlignment: .center, fontSize: 20)
    let logoView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLabel()
        configureLogo()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Initializes EmptyState with text
    /// - Parameter message: text passed to EmptyState label
    init(message: String) {
        super.init(frame: .zero)
        self.messageLabel.text = message
        configureLabel()
        configureLogo()
        
    }
    
    private func configureLabel() {
        let padding: CGFloat = 40
        addSubview(messageLabel)
        
        
        // custom label settings
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
                
        // constraints
        NSLayoutConstraint.activate([
        
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -155),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            messageLabel.heightAnchor.constraint(equalToConstant: padding * 5)
        ])
        
    }
    
    private func configureLogo() {
        addSubview(logoView)
        
        // imageView
        logoView.image = UIImage(named: "empty-state-logo")
        logoView.translatesAutoresizingMaskIntoConstraints = false
        
        // constraints
        NSLayoutConstraint.activate([
            
            logoView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            logoView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
        ])
    }
}
