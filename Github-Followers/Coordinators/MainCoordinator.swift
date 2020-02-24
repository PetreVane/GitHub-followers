//
//  MainCoordinator.swift
//  Github-Followers
//
//  Created by Petre Vane on 11/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit


class MainCoordinator: NSObject, Coordinator {

    var router = NavigationRouter()
    var presenter = NavigationRouter()
    var childCoordinators = [Coordinator]()
    
    
    func startSearchCoordinator() {
        
        let searchCoordinator = SearchCoordinator(navigationRouter: router)
        searchCoordinator.parent = self
        searchCoordinator.start()
        childCoordinators.append(searchCoordinator)
    }
    
    func startFavoritesCoordinator() {
        let favoritesRouter = NavigationRouter()
        let favoritesCoordinator = FavoritesCoordinator(navigationRouter: favoritesRouter)
        favoritesCoordinator.parent = self
        favoritesCoordinator.start()
        childCoordinators.append(favoritesCoordinator)
    }
    
    func startUserListCoordinator(withText text: String) {
        
        let userListCoordinator = UserListCoordinator(navigationRouter: router)
        userListCoordinator.parent = self
        childCoordinators.append(userListCoordinator)
        userListCoordinator.startUserList(withText: text)
    }
    
    func startFollowerInfoCoordinator(forFollower follower: Follower) {
        
        let followerInfoCoordinator = FollowerInfoCoordinator(navigationRouter: presenter)
        followerInfoCoordinator.parent = self
        childCoordinators.append(followerInfoCoordinator)
        followerInfoCoordinator.presentController(forFollower: follower)
    }
    
    func remove(_ coordinator: Coordinator) {
        for (index, child) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
            }
        }
    }
    
    func onDismissAction() {
        // does nothing; tabBar owns the MainCoordinator
    }
}

