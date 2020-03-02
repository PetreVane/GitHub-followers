//
//  FollowerCell.swift
//  Github-Followers
//
//  Created by Petre Vane on 09/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

/// Custom UICollectionViewCell subclass, owned by UserListController collectionView
class FollowerCell: UICollectionViewCell, Composer {
    
    static let reuseIdentifier = "followerCell"
    var avatarImageView = AvatarImageView(frame: .zero)
    var userNameLabel = TitleLabel(textAlignment: .center, fontSize: 12)
    var networkManager = NetworkManager.sharedInstance
    var cacheManager = CacheManager.sharedInstance
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    /// Sets cellImage & userNameLabel constraints
    private func configure() {
        
        self.addSubview(avatarImageView)
        self.addSubview(userNameLabel)
        translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
 
            userNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            userNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            userNameLabel.heightAnchor.constraint(equalToConstant: 20)
            
        ])
    }
}

