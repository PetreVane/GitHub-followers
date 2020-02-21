//
//  FavoritesCoordinator.swift
//  Github-Followers
//
//  Created by Petre Vane on 13/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

class FavoritesCoordinator: NSObject, Coordinator {
    
    var children = [Coordinator]()
    var navigationRouter: NavigationRouter
    
    init(navigationRouter: NavigationRouter) {
        self.navigationRouter = navigationRouter
        print("Favorites Coordinator has been initialized")
    }
    
    func printSomething(_ text: String) {
        print("Called FavoritesCoordinator with text: \(text)")
    }
    
    func start() {
        let favoritesController = FavoritesController.instantiate(delegate: self)
        favoritesController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        navigationRouter.present(favoritesController, animated: true)
    }
}

extension FavoritesCoordinator: FavoritesControllerDelegate {
    
}
