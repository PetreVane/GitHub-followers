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
    
    let mainCoordinator = MainCoordinator()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        mainCoordinator.startSearchCoordinator()
        mainCoordinator.startFavoritesCoordinator()
        
        viewControllers = presentTabbedControllers()
    }
    
    func presentTabbedControllers() -> [UIViewController]? {
        
        var viewControllers: [UIViewController]? = []
        let coordinators = mainCoordinator.childCoordinators
        for coordinator in coordinators {
            viewControllers?.append(coordinator.router.navigationController)
        }
      return viewControllers
    }
}
