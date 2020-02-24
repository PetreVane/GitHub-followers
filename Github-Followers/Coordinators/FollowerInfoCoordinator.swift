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
    
    func presentController(forFollower follower: Follower) {
        let followerInfoController = FollowerInfoController.instantiate(parentCoordinator: self)
        followerInfoController.gitHubFollower = follower
        router.present(followerInfoController, animated: true, onDismiss: onDismissAction)
        didStartController(followerInfoController)
    }
        
    func onDismissAction() {
        parent?.remove(self)
    }
    
    func didStartController(_ viewController: FollowerInfoController) {
        parent?.setFollowerInfoDelegate(viewController)
    }
}

extension FollowerInfoCoordinator: FollowerInfoCoordinatorDelegate {
    func dismissView() {
         router.dismiss(animated: true)
    }
}
