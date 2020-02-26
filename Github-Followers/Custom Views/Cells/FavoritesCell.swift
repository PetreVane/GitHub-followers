//
//  FavoritesCell.swift
//  Github-Followers
//
//  Created by Petre Vane on 24/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

class FavoritesCell: UITableViewCell {

    let avatarImageView = AvatarImageView(frame: .zero)
    let userNameLabel = TitleLabel(textAlignment: .left, fontSize: 25)
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
    
    /// Assigns text & image to cell label & cell imageView
    /// - Parameter follower: follower object for which avatar image and name are shown
    func show(_ follower: Follower) {
        
        userNameLabel.text = follower.login

        // checks if the avatarImage already exists in cache
        if let cachedImage = cacheManager.retrieveImage(withIdentifier: follower.avatarURL) {
            avatarImageView.image = nil
            DispatchQueue.main.async { self.avatarImageView.image = cachedImage }
            return
            
        } else {
            
            networkManager.fetchAvatars(from: follower.avatarURL) { [weak self] image in
                guard let self = self else { return }
                DispatchQueue.main.async { self.avatarImageView.image = image }
                self.cacheManager.saveImage(withIdentifier: follower.avatarURL, image: image)
            }
        }
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
