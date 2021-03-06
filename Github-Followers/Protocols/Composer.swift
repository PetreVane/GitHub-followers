//
//  Composer.swift
//  Github-Followers
//
//  Created by Petre Vane on 02/03/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit
import CustomUIElements



// adopted by FollowerCell & FavoritesCell
/// Defines a number of properties and implements a method, each Cell should have
///
/// - contains a defaul implementation of e network request, responsible with fetching the imageViews, shown by each cell
protocol Composer: class {
    
    var avatarImageView: AvatarImageView { get set }
    var userNameLabel: TitleLabel { get set }
    var networkManager: NetworkManager { get set }
    var cacheManager: CacheManager { get set }
    
    func show(_ follower: Follower)
}


extension Composer {
    
    /// Assigns text & image to a collectionView cell
    /// - Parameter follower: Github follower instance
    func show(_ follower: Follower) {
        userNameLabel.text = follower.login
        
        // checks if the image already exists in cache
        if let cachedImage = cacheManager.retrieveImage(withIdentifier: follower.avatarURL) {
            DispatchQueue.main.async { self.avatarImageView.image = cachedImage }; return
        }
        
        // if there is no image in cache, proceeds with fetching the image from the network
        networkManager.fetchAvatars(from: follower.avatarURL)  { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.avatarImageView.image = image }
            // saves image to cache
            self.cacheManager.saveImage(withIdentifier: follower.avatarURL, image: image)
        }
    }
}
