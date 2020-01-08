//
//  User.swift
//  Github-Followers
//
//  Created by Petre Vane on 08/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import Foundation


struct User: Codable {
    
    let login: String
    let avatarURL: String
    let name: String?
    let location: String?
    let email, bio: String?
    let publicRepos, publicGists, followers, following: Int
    let htmlURL: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        
        case login
        case avatarURL = "avatar_url"
        case name
        case location, email, bio
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers, following
        case htmlURL = "html_url"
        case createdAt = "created_at"
     }
}
