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
    let networkManager = NetworkManager.sharedInstance
    let cacheManager = CacheManager.sharedInstance
    let userNameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    let cellImage = GFAvatarImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Assigns text & image collectionView cell label and UIImage
    /// - Parameter follower: Github follower instance
    func set(follower: Follower) {
        userNameLabel.text = follower.login
        
        // checks if the image already exists in cache
        if let cachedImage = cacheManager.retrieveImage(withIdentifier: follower.avatarURL) {

            DispatchQueue.main.async { self.cellImage.image = cachedImage }
//            print("Avatar fetched from cache")
            return
        }
        
        // if there is no image in cache, proceeds with fetching the image from the network
        networkManager.fetchAvatars(from: follower.avatarURL)  { [weak self] image in
                        
            guard let self = self else { return }
            DispatchQueue.main.async { self.cellImage.image = image }
            
            // saves image to cache
            self.cacheManager.saveImage(withIdentifier: follower.avatarURL, image: image)
//            print("Avatar saved to cache")
        }
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
