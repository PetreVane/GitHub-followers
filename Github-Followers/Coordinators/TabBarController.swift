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

        viewControllers = [startSearchCoordinator(), createFavoritesNavController()]
    }
    

    /// Starts FavoritesController() and adds it to a NavigationController object
    private func createFavoritesNavController() -> UINavigationController {
                
        let favoritesCoordinator = FavoritesCoordinator(navigationController: UINavigationController())
        let favoritesNavController = favoritesCoordinator.startFavoritesController()
        
        return favoritesNavController
        
    }
    
    /// Starts SearchController() and adds it to a NavigationController object
    private func startSearchCoordinator() -> UINavigationController {
                
        let searchCoordinator = SearchCoordinator(navigationController: UINavigationController())
        let searchNavController = searchCoordinator.startSearchController()
        return searchNavController
    }

}
