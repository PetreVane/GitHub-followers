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
        print("MainCoordinator has been initialized")
    }
    
}
