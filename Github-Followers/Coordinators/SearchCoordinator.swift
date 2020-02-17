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
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        print("SearchCoordinator has been initialized")
    }
    
    
    func printSomething(_ text: String) {
        print("SearchCoordinator called with text: \(text)")
        let userList = UsersListController()
        userList.parentCoordinator = self
        userList.typedUserName = text
        navigationController.pushViewController(userList, animated: true)
    }
        
    func start() {
        
        let searchController = SearchController()
        searchController.parentCoordinator = self
        searchController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        navigationController.pushViewController(searchController, animated: true)
    }
    
    
}
