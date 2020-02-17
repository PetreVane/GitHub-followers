//
//  FavoritesCoordinator.swift
//  Github-Followers
//
//  Created by Petre Vane on 13/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

class FavoritesCoordinator: NSObject, Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        print("Favorites Coordinator has been initialized")
    }
    
    func printSomething(_ text: String) {
        print("Called FavoritesCoordinator with text: \(text)")
    }
    
    func start() {
        let favoritesController = FavoritesController()
        favoritesController.parentCoordinator = self
        favoritesController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        navigationController.pushViewController(favoritesController, animated: true)
    }
    
    
    
}
