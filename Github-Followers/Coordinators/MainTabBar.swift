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
/// - Creates a new TabBar object, which contains a reference to MainCoordinator.
/// - The MainCoordinator starts 2 coordinators, and each of them starts a ViewController, embeded in its own navigation controller.
/// - The MainTabBar owns those navigationControllers.
class MainTabBar: UITabBarController {
    
    let mainCoordinator = MainCoordinator()

    override func viewDidLoad() {
        super.viewDidLoad()
        mainCoordinator.startSearchCoordinator()
        mainCoordinator.startFavoritesCoordinator()
        
        viewControllers = presentTabbedControllers()
    }
    
    /// Adds 2 navigationControllers to TabBar 'viewControllers' list.
    ///
    /// Each of those navigationControllers contains a ViewController that gets displayed by MainTabBar.
    func presentTabbedControllers() -> [UIViewController]? {
        
        var viewControllers: [UIViewController]? = []
        let childCoordinators = mainCoordinator.childCoordinators
        for coordinator in childCoordinators {
            viewControllers?.append(coordinator.router.navigationController)
        }
      return viewControllers
    }
}
