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
    
    
    // navigationRouter is not passed to controller yet, but it should.
    func start() {
        let viewController = FavoritesController.instantiate(delegate: self)
        viewController.coordinator = self
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        router.present(viewController, animated: true, onDismiss: onDismissAction)
    }
    
    func onDismissAction() {
        parent?.remove(self)
    }
    
    func setNavigationBarLargeTitle() {
        router.navigationController.navigationBar.prefersLargeTitles = true
    }
    
    func presentFollowersFor(_ favorite: Follower) {
        parent?.startUserListCoordinator(withText: favorite.login, navRouter: router as? NavigationRouter)
    }
}

extension FavoritesCoordinator: FavoritesControllerDelegate {
    
}
