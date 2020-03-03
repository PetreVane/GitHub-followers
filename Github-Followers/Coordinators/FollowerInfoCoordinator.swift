//
//  FollowerInfoCoordinator.swift
//  Github-Followers
//
//  Created by Petre Vane on 13/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit


/// Concrete coordinator which implements the coordinator protocol.
///
/// It knows how to create concrete view controllers and sets itself as delegate for its viewController.
class FollowerInfoCoordinator: Coordinator {
    
    var router: Router
    weak var parent: MainCoordinator?
    
    init(navigationRouter: NavigationRouter) {
        self.router = navigationRouter
    }
    
    /// Starts FollowerInfo view controller and sets itself as coordinator / delegate
    /// - Parameter follower: follower that gets displayed
    ///
    /// Also, sets itself as coordinator / delegate of FollowerInfo  view controller. See extension.
    func presentController(forFollower follower: Follower) {
        let followerInfoController = FollowerInfoController.instantiate(parentCoordinator: self)
        followerInfoController.gitHubFollower = follower
        router.present(followerInfoController, animated: true, onDismiss: onDismissAction)
        didStartController(followerInfoController)
    }
    
    /// Asks MainCoordinator (parent coordinator) to remove self from childCoordinator list.
    func onDismissAction() {
        parent?.remove(self)
    }
    
    /// Informs parent coordinator that FollowerInfo view controller has been displayed.
    /// - Parameter viewController: FollowerInfo viewController
    ///
    ///  - This is useful because FollowerInfo ViewController needs to tell UserList ViewController to fetch followers for a different GitHub user.
    ///  - Therefore, UserList ViewController needs to assign itself as delegate of FollowerInfo ViewController
    func didStartController(_ viewController: FollowerInfoController) {
        parent?.setFollowerInfoDelegate(viewController)
    }
    
}

extension FollowerInfoCoordinator: FollowerInfoCoordinatorDelegate {
 
    /// Asks the router to dismiss FolloweInfo ViewController 
    func dismissView() {
         router.dismiss(animated: true)
    }
}
