//
//  UserListCoordinator.swift
//  Github-Followers
//
//  Created by Petre Vane on 13/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit


/// Concrete coordinator which implements the coordinator protocol.
///
/// It knows how to create concrete view controllers and sets itself as delegate for its viewController.
class UserListCoordinator: Coordinator {
    
    var router: Router
    var parent: MainCoordinator?
    init( navigationRouter: NavigationRouter) {
        self.router = navigationRouter
    }
    
    /// Starts UserList view controller and sets itself as coordinator / delegate
    /// - Parameter text: text passed in from SearchController textField
    ///
    /// Also, sets itself as coordinator / delegate of UserList view controller. See extension.
    func startUserList(withText text: String) {
        let viewController = UsersListController.instantiate(parentCoordinator: self)
        viewController.typedUserName = text
        
        /*
            Sets UsersListController as the starting / base ViewController in a new NavigationRouter object, belonging to MainCoordinator.
            This happens because the router which presents the UserListController, cannot present another ViewController modally.
            And the FollowerInfoViewController should be presented modally.
         */
        parent?.presenter.baseViewController = viewController
        router.present(viewController, animated: true, onDismiss: onDismissAction)
    }
    
    /// Asks MainCoordinator (parent coordinator) to remove self from childCoordinator list.
    func onDismissAction() {
        parent?.remove(self)
    }
}

extension UserListCoordinator: UserListCoordinatorDelegate {
    
    /// Sets itself as delegate for UserList view controller
    /// - Parameters:
    ///   - viewController: view controller informing its delegate that a cell has been pressed
    ///   - follower: follower cell presed by user
    func userListControllerDidSelectFollower(follower: Follower) {
        parent?.startFollowerInfoCoordinator(forFollower: follower)
    }
}
