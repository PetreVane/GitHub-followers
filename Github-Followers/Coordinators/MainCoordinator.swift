//
//  MainCoordinator.swift
//  Github-Followers
//
//  Created by Petre Vane on 11/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit


///  Concrete coordinator implements the coordinator protocol.
///
///  It knows how to create concrete child coordinators and the order in which view controllers should be displayed.
class MainCoordinator: NSObject, Coordinator {
   
    var router: Router = NavigationRouter()
    var presenter = NavigationRouter()
    var childCoordinators = [Coordinator]()
    
    
    /// Starts Search view controller coordinator
    func startSearchCoordinator() {
        
        let searchCoordinator = SearchCoordinator(navigationRouter: router as! NavigationRouter)
        searchCoordinator.parent = self
        searchCoordinator.start()
        childCoordinators.append(searchCoordinator)
    }
    
    /// Starts Favorites view controller coordinator
    func startFavoritesCoordinator() {
        let favoritesRouter = NavigationRouter()
        let favoritesCoordinator = FavoritesCoordinator(navigationRouter: favoritesRouter)
        favoritesCoordinator.parent = self
        favoritesCoordinator.start()
        childCoordinators.append(favoritesCoordinator)
    }
    
    /// Starts UserList view controller coordinator
    /// - Parameter text: user typed text, contained by Search Controller textField
    func startUserListCoordinator(withText text: String) {
        
        let userListCoordinator = UserListCoordinator(navigationRouter: router as! NavigationRouter)
        userListCoordinator.parent = self
        childCoordinators.append(userListCoordinator)
        userListCoordinator.startUserList(withText: text)
    }
    
    /// Starts FollowerInfo view controller coordinator
    /// - Parameter follower: user selected follower cell
    func startFollowerInfoCoordinator(forFollower follower: Follower) {
        
        let followerInfoCoordinator = FollowerInfoCoordinator(navigationRouter: presenter)
        followerInfoCoordinator.parent = self
        childCoordinators.append(followerInfoCoordinator)
        followerInfoCoordinator.presentController(forFollower: follower)
    }
    
    /// Removes child coordinator from childCoordinator array
    /// - Parameter coordinator: child coordinator that should be removed
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
    
    /// Sets the UserList view controller as delegate for FollowerInfo view controller
    /// - Parameter viewController: FollowerInfo view controller reference
    func setFollowerInfoDelegate(_ viewController: FollowerInfoController) {
        viewController.delegate = router.navigationController.viewControllers.last as? FollowerInfoControllerDelegate
    }
    
}

