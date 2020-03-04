//
//  RepoCard.swift
//  Github-Followers
//
//  Created by Petre Vane on 29/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

// adopted by FollowerInfoController
protocol RepoCardDelegate: class {
    func didTapProfileButton(forUser user: User)
}

/// Concrete implementation of UIViews inherited from ReusableCardController
class RepoCard: ReusableCardController {
    
    weak var delegate: RepoCardDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    init(user: User, delegate: RepoCardDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Calls a method on a superClass property, to set its content type
    ///
    /// Sets the content type for (superClass) firstView property, by calling the set() method of ReusableCardView() class
    private func configureViews() {
        leftView.set(contentType: .repos, withCount: user.publicRepos)
        rightView.set(contentType: .gist, withCount: user.publicGists)
        actionButton.setButton(color: .systemPurple, title: "GitHub Profile")
    }
    
    /// Tells the delegate that the 'GitHub profile' button was tapped.
    override func actionButtonTapped() {
        delegate?.didTapProfileButton(forUser: user)
    }
}
