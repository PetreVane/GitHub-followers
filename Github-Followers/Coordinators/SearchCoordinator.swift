//
//  SearchCoordinator.swift
//  Github-Followers
//
//  Created by Petre Vane on 13/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

/// Concrete coordinator which implements the coordinator protocol.
///
/// It knows how to create concrete view controllers and sets itself as delegate for its viewController.
class SearchCoordinator: NSObject, Coordinator {
    
    var router: Router 
    var parent: MainCoordinator?
    init(navigationRouter: NavigationRouter) {
        self.router = navigationRouter
    }
    
    /// Starts Search view controller and asks the router to present it
    ///
    /// Also, sets itself as delegate for coordinator / delegate. See extension
    func start() {
        let viewController = SearchController.instantiate(parentCoordinator: self)
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        router.present(viewController, animated: true, onDismiss: onDismissAction)
    }
    
    /// Asks MainCoordinator (parent coordinator) to remove self from childCoordinator list.
    func onDismissAction() {
        parent?.remove(self)
    }
}

extension SearchCoordinator: SearchControllerCoordinatorDelegate {
    
    /// Sets itself (SearchCoordinator) as delegate of Search viewController
    /// - Parameters:
    ///   - viewController: Search view controller
    ///   - text: text contained by SearchController textField
    func searchControllerDidPressSearchButton(_ viewController: SearchController, withText text: String) {
        parent?.startUserListCoordinator(withText : text)
    }
}
