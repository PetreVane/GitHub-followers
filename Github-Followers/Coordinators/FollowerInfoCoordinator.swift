//
//  FollowerInfoCoordinator.swift
//  Github-Followers
//
//  Created by Petre Vane on 13/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit


class FollowerInfoCoordinator: Coordinator {
    
    var router: NavigationRouter
    weak var parent: MainCoordinator?
    
    init(navigationRouter: NavigationRouter) {
        self.router = navigationRouter
    }
    
    func presentController(forFollower follower: Follower) {
        print("FollowerInfoCoordinator called for follwer: \(follower.login)")
        let followerInfoController = FollowerInfoController.instantiate(parentCoordinator: self)
        followerInfoController.gitHubFollower = follower
        router.present(followerInfoController, animated: true, onDismiss: onDismissAction)
    }
    
    func onDismissAction() {
        parent?.remove(self)
    }
}

extension FollowerInfoCoordinator: FollowerInfoCoordinatorDelegate {
    
}
