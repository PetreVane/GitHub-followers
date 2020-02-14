//
//  FollowerInfoDelegate.swift
//  Github-Followers
//
//  Created by Petre Vane on 04/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import Foundation

// Adopted by UsersListController() (extension)
protocol FollowerInfoDelegate: class {
    func didRequestFollowers(for user: User)
}
