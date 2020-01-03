//
//  SceneDelegate.swift
//  Github-Followers
//
//  Created by Petre Vane on 30/12/2019.
//  Copyright © 2019 Petre Vane. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // init window with the frameSize of the windowScene bounds
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        
        //assign windowScene to window
        window?.windowScene = windowScene
        
        //assign the root ViewController
        window?.rootViewController = createTabBar()
        
        // show the ViewController
        window?.makeKeyAndVisible()
    }
    
    
    /// Adds a Navigation controller for SearchViewController()
    func createSearchNavController() -> UINavigationController {
        let seachVC = SearchViewController()
        seachVC.title = "Search"
        seachVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        let searchNavController = UINavigationController(rootViewController: seachVC)
        return searchNavController
    }
    
    /// Adds a Navigation controller for FavoritesViewController()
    func createFavoritesNavController() -> UINavigationController {
        
        let favoritesVC = FavoritesViewController()
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        let favNavController = UINavigationController(rootViewController: favoritesVC)
        return favNavController
        
    }
    
    /// Adds a TabBar controller & assigns the Navigation controllers to it
    func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        tabBar.viewControllers = [createSearchNavController(), createFavoritesNavController()]
        
        // adding tint color for TabBar
        UITabBar.appearance().tintColor = .systemGreen
        
        return tabBar
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

