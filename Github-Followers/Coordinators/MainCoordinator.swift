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
        router.navigationController.delegate = self
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
            }
        }
    }
}


extension MainCoordinator: UINavigationControllerDelegate {
    
    
    /// Dismisses a viewController when the NavigationController back button is pressed
    /// - Parameters:
    ///   - navigationController: navigationController containing the ViewController that is being presented
    ///   - viewController: ViewController that is about to be dimissed
    ///   - animated: true if animations are desired
    /// - establishes which ViewController is being dismissed
    /// - makes sure the navigationController list of ViewControlled no longer contains the dismissed viewController
    /// - calls any closures for the dismissed viewController, if any
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let dismissedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        guard !navigationController.viewControllers.contains(dismissedViewController) else { return }
        router.performOnDismissAction(for: dismissedViewController)
//        self.remove(dismissedViewController)
    }
}
