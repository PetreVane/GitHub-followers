//
//  SearchCoordinator.swift
//  Github-Followers
//
//  Created by Petre Vane on 13/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

/// Coordinates SearchController
///
/// Creates an object of SearchController and assigns it to a NavigationController object
class SearchCoordinator: Coordinator {
    
    weak var coordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    /// Creates an object of SearchController
    ///
    /// This method creates an object of SearchController and assigns self as childCoordinator. Then, embeds SearchController into navigationController passed at class initialization.
    func startSearchController() -> UINavigationController {
        
        let seachVC = SearchController()
        seachVC.parentCoordinator = self
        seachVC.title = "Search"
        seachVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        navigationController.viewControllers = [seachVC]
        return navigationController
    }
    
    func showFollowers(for user: String) {
        
    }
    
    func searchButtonPressed(withText: String) {
        
    }
    
}
