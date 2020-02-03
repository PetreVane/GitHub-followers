//
//  SecondCard.swift
//  Github-Followers
//
//  Created by Petre Vane on 29/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

class FollowersCard: ReusableCardController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
    }
    
    
    /// Calls a method on a superClass property, to set its content type
    ///
    /// Sets the content type for (superClass) firstView property, by calling the set() method of ReusableCardView() class
    private func configureViews() {
        firstView.set(contentType: .followers, withCount: user.followers)
        secondView.set(contentType: .following, withCount: user.following)
        actionButton.setButton(color: .systemGreen, title: "Get Followers")
    }
}
