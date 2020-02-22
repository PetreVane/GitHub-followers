//
//  FavoritesCoordinator.swift
//  Github-Followers
//
//  Created by Petre Vane on 13/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

class FavoritesCoordinator: NSObject, Coordinator {

    var router: NavigationRouter
    var parent: MainCoordinator?
    init(navigationRouter: NavigationRouter) {
        self.router = navigationRouter
    }
    
    func printSomething(_ text: String) {
        print("Called FavoritesCoordinator with text: \(text)")
    }
    
    // navigationRouter is not passed to controller yet, but it should.
    func start() {
        let viewController = FavoritesController.instantiate(parentCoordinator: self)
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        router.present(viewController, animated: true, onDismiss: onDismissAction)
    }
    
    func onDismissAction() {
        parent?.remove(self)
    }
}

extension FavoritesCoordinator: FavoritesControllerDelegate {
    
}
