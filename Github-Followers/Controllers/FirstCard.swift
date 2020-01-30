//
//  FirstCard.swift
//  Github-Followers
//
//  Created by Petre Vane on 29/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit


class FirstCard: ReusableCardController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
    }
    
    
    /// Calls a method on a superClass property, to set its content type
    ///
    /// Sets the content type for (superClass) firstView property, by calling the set() method of ReusableView() class
    private func configureViews() {
        firstView.set(contentType: .repos, withCount: user.publicRepos)
        secondView.set(contentType: .gist, withCount: user.publicGists)
        actionButton.setButton(color: .systemPurple, title: "GitHub Profile")
    }
}
