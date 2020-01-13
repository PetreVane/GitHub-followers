//
//  FollowerCell.swift
//  Github-Followers
//
//  Created by Petre Vane on 09/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseIdentifier = "followerCell"
    let userNameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    let cellImage = GFAvatarImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        userNameLabel.text = follower.login
    }
    
    private func configure() {
        self.addSubview(cellImage)
        self.addSubview(userNameLabel)
        translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            cellImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            cellImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            cellImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            cellImage.heightAnchor.constraint(equalTo: cellImage.widthAnchor),
 
            userNameLabel.topAnchor.constraint(equalTo: cellImage.bottomAnchor, constant: 12),
            userNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            userNameLabel.heightAnchor.constraint(equalToConstant: 20)
            
        ])
    }
}
