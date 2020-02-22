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
        router.present(viewController, animated: true, onDismiss: onDismissAction)
    }
    
    func onDismissAction() {
        parent?.remove(self)
    }
}

extension UserListCoordinator: UserListCoordinatorDelegate {
    
    func userListControllerDidSelectFollower(_ viewController: UsersListController, follower: Follower) {
        print("UserListCoordinator called for follwer: \(follower.login)")
    }

}
