//
//  FavoritesCoordinator.swift
//  Github-Followers
//
//  Created by Petre Vane on 13/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

/// Concrete coordinator which implements the coordinator protocol.
///
/// It knows how to create concrete view controllers and sets itself as delegate for its viewController.
class FavoritesCoordinator: NSObject, Coordinator {

    var router: Router
    var parent: MainCoordinator?
    init(navigationRouter: NavigationRouter) {
        self.router = navigationRouter
    }
    
    /// Starts Favorites (View)Controller
    func start() {
        let viewController = FavoritesController.instantiate(coordinator: self)
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        router.present(viewController, animated: true, onDismiss: onDismissAction)
    }
    
    /// Removes itself from parent's list of child coordinators
    func onDismissAction() {
        parent?.remove(self)
    }
    
    /// Sets NavigationBar with large titles
    func setNavigationBarLargeTitle() {
        router.navigationController.navigationBar.prefersLargeTitles = true
    }
    
    /// Asks the parent coordinator to instantiate UserListCoordinator
    /// - Parameter favorite: Follower object for which the UserListController is (eventually) called
    func presentFollowersFor(_ favorite: Follower) {
        parent?.startUserListCoordinator(withText: favorite.login, navigationRouter: router as? NavigationRouter)
    }
}

