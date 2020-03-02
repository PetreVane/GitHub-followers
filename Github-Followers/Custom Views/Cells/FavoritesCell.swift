//
//  FavoritesCell.swift
//  Github-Followers
//
//  Created by Petre Vane on 24/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

class FavoritesCell: UITableViewCell, Composer {
    
    static let reuseIdentifier = "FavoritesCell"
    var avatarImageView = AvatarImageView(frame: .zero)
    var userNameLabel = TitleLabel(textAlignment: .left, fontSize: 25)
    
    var networkManager = NetworkManager.sharedInstance
    var cacheManager = CacheManager.sharedInstance
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Sets avatarImage & userNameLabel constraints
    private func configure() {
        addSubview(avatarImageView)
        addSubview(userNameLabel)
    
        let padding: CGFloat = 12
        accessoryType = .disclosureIndicator
        
        NSLayoutConstraint.activate([
        
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            userNameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding * 4),
            userNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            userNameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = AvatarImageView.imagePlaceholder
        userNameLabel.text = nil
    }
    
}

extension FavoritesCell: Comparable {
    
    static func < (lhs: FavoritesCell, rhs: FavoritesCell) -> Bool {
        return lhs.userNameLabel.text! < rhs.userNameLabel.text!
    }
}
