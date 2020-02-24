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
            
    func start() {
        let viewController = SearchController.instantiate(parentCoordinator: self)
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        router.present(viewController, animated: true, onDismiss: onDismissAction)
    }
    
    func onDismissAction() {
        parent?.remove(self)
    }
}

extension SearchCoordinator: SearchControllerCoordinatorDelegate {
    
    func searchControllerDidPressSearchButton(_ viewController: SearchController, withText text: String) {
        parent?.startUserListCoordinator(withText : text)
    }
}
