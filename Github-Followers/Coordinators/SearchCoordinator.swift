//
//  SearchCoordinator.swift
//  Github-Followers
//
//  Created by Petre Vane on 13/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

class SearchCoordinator: NSObject, Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationRouter: NavigationRouter?
    
    
//    func printSomething(_ text: String) {
//        print("SearchCoordinator called with text: \(text)")
//        let userList = UsersListController()
//        userList.parentCoordinator = self
//        userList.typedUserName = text
//        navigationController.pushViewController(userList, animated: true)
//    }
        
    func start() {
        let viewController = SearchController.instantiate(delegate: self)
        viewController.parentCoordinator = self
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        navigationRouter = NavigationRouter(viewController: viewController)
        navigationRouter?.present(viewController, animated: true, onDismiss: nil)
    }
}

extension SearchCoordinator: SearchControllerDelegate {
    
    func searchControllerDidPressSearchButton(_ viewController: SearchController, withText text: String) {
        print("SearchController delegate called with text: \(text)")
    }
}
