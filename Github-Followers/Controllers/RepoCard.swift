//
//  RepoCard.swift
//  Github-Followers
//
//  Created by Petre Vane on 29/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

class RepoCard: ReusableCardController {
    
    weak var delegate: RepoCardDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    
    /// Calls a method on a superClass property, to set its content type
    ///
    /// Sets the content type for (superClass) firstView property, by calling the set() method of ReusableCardView() class
    private func configureViews() {
        leftView.set(contentType: .repos, withCount: user.publicRepos)
        rightView.set(contentType: .gist, withCount: user.publicGists)
        actionButton.setButton(color: .systemPurple, title: "GitHub Profile")
    }
    
    override func actionButtonTapped() {
        delegate?.didTapProfileButton(forUser: user)
    }
}
