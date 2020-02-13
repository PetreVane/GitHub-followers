//
//  TabBarController.swift
//  Github-Followers
//
//  Created by Petre Vane on 13/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

/// Creates a tabBar holding two objects
///
/// Creates a new TabBar object, which contains a reference to SearchVC and one to FavoritesVC
class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [createSearchNavController(), createFavoritesNavController()]
    }
    

    /// Adds a Navigation controller for FavoritesController()
    private func createFavoritesNavController() -> UINavigationController {
        
        let favoritesVC = FavoritesController()
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        let favNavController = UINavigationController(rootViewController: favoritesVC)
        
        return favNavController
        
    }
    
    /// Adds a Navigation controller for SearchViewController()
    private func createSearchNavController() -> UINavigationController {
        
        let seachVC = SearchController()
        seachVC.title = "Search"
        seachVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let searchNavController = UINavigationController(rootViewController: seachVC)
        return searchNavController
    }

}
