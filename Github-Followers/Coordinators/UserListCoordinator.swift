//
//  UserListCoordinator.swift
//  Github-Followers
//
//  Created by Petre Vane on 13/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

class UserListCoordinator: Coordinator {
    
    var router: NavigationRouter
    var parent: MainCoordinator?
    init( navigationRouter: NavigationRouter) {
        self.router = navigationRouter
    }
    
    func startUserList(withText text: String) {
        let viewController = UsersListController.instantiate(parentCoordinator: self)
        viewController.typedUserName = text
        /*
            Sets UsersListController as the starting / presenter ViewController in a new NavigationRouter object, belonging to MainCoordinator.
            This happens because the router which presents the UserListController, cannot present another ViewController modally.
            And the FollowerInfoViewController should be presented modally.
         */
        parent?.presenter.baseViewController = viewController
        router.present(viewController, animated: true, onDismiss: onDismissAction)
    }
    
    func onDismissAction() {
        parent?.remove(self)
    }
}

extension UserListCoordinator: UserListCoordinatorDelegate {
    
    func userListControllerDidSelectFollower(_ viewController: UsersListController, follower: Follower) {
        parent?.startFollowerInfoCoordinator(forFollower: follower)
    }
}
