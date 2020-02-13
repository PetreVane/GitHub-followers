//
//  FavoritesCoordinator.swift
//  Github-Followers
//
//  Created by Petre Vane on 13/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

/// Coordinates FavoritesController
///
/// Creates an object of FavoritesController and assigns it to a NavigationController object
class FavoritesCoordinator: Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    /// Creates an object of FavoritesController
    ///
    /// This method creates an object of FavoritesController and assigns self as childCoordinator. Then, embeds FacoritesController into navigationController passed at class initialization.
    func startFavoritesController() -> UINavigationController {
        
        let favController = FavoritesController()
        favController.childCoordinator = self
        favController.title = "Favorites"
        favController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        navigationController.viewControllers = [favController]
        return navigationController
    }
}
