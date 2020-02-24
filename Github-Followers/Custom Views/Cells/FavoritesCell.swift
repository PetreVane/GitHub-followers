//
//  FavoritesCell.swift
//  Github-Followers
//
//  Created by Petre Vane on 24/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

class FavoritesCell: UITableViewCell {

    private let avatarImageView = AvatarImageView(frame: .zero)
    private let userNameLabel = TitleLabel(textAlignment: .left, fontSize: 25)
    static let reuseIdentifier = "FavoritesCell"
    let networkManager = NetworkManager.sharedInstance
    let cacheManager = CacheManager.sharedInstance
    
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
        
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            userNameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding * 2),
            userNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            userNameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    /// Assigns text & image to cell label & cell imageView
    /// - Parameter follower: follower object for which avatar image and name are shown
    private func show(_ follower: Follower) {
        userNameLabel.text = follower.login
        
        // checks if the avatarImage already exists in cache
        if let cachedImage = cacheManager.retrieveImage(withIdentifier: follower.avatarURL) {
            
            DispatchQueue.main.async { self.avatarImageView.image = cachedImage }; return
        }
        
        networkManager.fetchAvatars(from: follower.avatarURL) { [weak self] image in
            
            guard let self = self else { return }
            DispatchQueue.main.async { self.imageView?.image = image }
            self.cacheManager.saveImage(withIdentifier: follower.avatarURL, image: image)
        }
    }
}
