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

    let messageLabel = TitleLabel(textAlignment: .center, fontSize: 20)
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
    convenience init(message: String) {
        self.init(frame: .zero)
        self.messageLabel.text = message
    }
    
    private func configureLabel() {
        let padding: CGFloat = 40
        addSubview(messageLabel)
        
        // custom label settings
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        // checks if device is iPhone SE and sets a smaller padding for
        let labelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -100 : -150
        let messageLabelCenterConstraint = messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstant)
        messageLabelCenterConstraint.isActive = true
        
        // constraints
        NSLayoutConstraint.activate([
        
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            messageLabel.heightAnchor.constraint(equalToConstant: padding * 5)
        ])
        
    }
    
    private func configureLogo() {
        addSubview(logoView)
        
        // imageView
        logoView.image = Images.emptyStateLogo
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
