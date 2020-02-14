//
//  MainCoordinator.swift
//  Github-Followers
//
//  Created by Petre Vane on 11/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit


class MainCoordinator: NSObject, Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        print("MainCoordinator has been initialized")
    }
    
    
    func startSearchController() -> UIViewController {
        let searchVC = SearchController()
        searchVC.parentCoordinator = self
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        _ = UINavigationController(rootViewController: searchVC)
        return searchVC
    }
    
    
    func startFavoritesController() -> UIViewController {
        let favController = FavoritesController()
        favController.parentCoordinator = self
        favController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        _ =  UINavigationController(rootViewController: favController)
        return favController
    }
    
    func printSomething(_ text: String) {
        print("MainCoordinator called with text: \(text)")
    }
    
    
}
