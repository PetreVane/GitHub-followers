//
//  MainCoordinator.swift
//  Github-Followers
//
//  Created by Petre Vane on 11/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit


class MainCoordinator: NSObject, Coordinator {

    var router: NavigationRouter
    var childCoordinators = [Coordinator]()
    
    init(navigationRouter: NavigationRouter) {
        self.router = navigationRouter
        super.init()
    }
    
    func startSearchCoordinator() {
        
        let searchCoordinator = SearchCoordinator(navigationRouter: router)
        searchCoordinator.parent = self
        searchCoordinator.start()
        childCoordinators.append(searchCoordinator)
        print("ChildCoordinators contains: \(childCoordinators)")
    }
    
    func startFavoritesCoordinator() {
        
        let favoritesCoordinator = FavoritesCoordinator(navigationRouter: NavigationRouter())
        favoritesCoordinator.parent = self
        favoritesCoordinator.start()
        childCoordinators.append(favoritesCoordinator)
        print("ChildCoordinators contains: \(childCoordinators)")
    }
    
    func startUserListCoordinator(withText text: String) {
        let userListCoordinator = UserListCoordinator(navigationRouter: router)
        userListCoordinator.parent = self
        childCoordinators.append(userListCoordinator)
        userListCoordinator.startUserList(withText: text)
        print("ChildCoordinators contains: \(childCoordinators)")
    }
    
    func remove(_ coordinator: Coordinator) {
        for (index, child) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                print("ChildCoordinators contains: \(childCoordinators)")
            }
        }
    }
    
    func onDismissAction() {
        // does nothing; tabBar owns the MainCoordinator
    }
}

