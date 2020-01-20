//
//  EmptyState.swift
//  Github-Followers
//
//  Created by Petre Vane on 20/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

class EmptyState: UIView {

    let messageLabel =  GFTitleLabel(textAlignment: .center, fontSize: 25)
    let logoView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLabel()
        configureLogo()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        self.messageLabel.text = message
        configureLabel()
        
    }
    
    private func configureLabel() {
        let padding: CGFloat = 40
        addSubview(messageLabel)
        
        
        // custom label settings
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
                
        // constraints
        NSLayoutConstraint.activate([
        
            // messageLabel
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
        
        NSLayoutConstraint.activate([
            
            logoView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 200),
            logoView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 140)
        ])
    }
}
