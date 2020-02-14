//
//  RepoCardDelegate.swift
//  Github-Followers
//
//  Created by Petre Vane on 03/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import Foundation

// Adopted by FollowerInfoController (extension)
protocol RepoCardDelegate: class {
    func didTapProfileButton(forUser user: User)
}
