//
//  MainTabBar.swift
//  Github-Followers
//
//  Created by Petre Vane on 13/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//


import UIKit

/// Creates a tabBar object
///
/// Creates a new TabBar object, which contains a reference to MainCoordinator.
/// The MainCoordinator start() method returns an array of navigationControllers, each of them containing a screen
class MainTabBar: UITabBarController {
    
    let searchCoordinator = SearchCoordinator(navigationRouter: NavigationRouter())
    let favoritesCoordinator = FavoritesCoordinator(navigationRouter: NavigationRouter())

    override func viewDidLoad() {
        super.viewDidLoad()
        searchCoordinator.start()
        favoritesCoordinator.start()
        
        viewControllers = [searchCoordinator.router.navigationController, favoritesCoordinator.router.navigationController]
    }
}
