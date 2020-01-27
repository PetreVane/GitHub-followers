//
//  HeaderVC.swift
//  Github-Followers
//
//  Created by Petre Vane on 25/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

class HeaderVC: UIViewController {

    let followerImageView = AvatarImageView(frame: .zero)
    let userNameLabel = TitleLabel(textAlignment: .left, fontSize: 30)
    let realNameLabel = SecondaryTitleLabel(fontSize: 16)
    let locationView = UIImageView()
    let locationNameLabel = SecondaryTitleLabel(fontSize: 16)
    let bioLabel = BodyLabel(textAlignment: .left)
    var user: User!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addSubViews()
        userNameLabel.text = user.login
        realNameLabel.text = user.name
        locationNameLabel.text = user.location
    }
    

    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// Adds custom subviews to current ViewController
    func addSubViews() {
        view.addSubview(followerImageView)
        view.addSubview(userNameLabel)
        view.addSubview(realNameLabel)
        view.addSubview(locationView)
        view.addSubview(locationNameLabel)
        view.addSubview(bioLabel)
        
    }
    
    /// Sets constraints for ViewController objects
    func setConstraints() {
        
        let padding: CGFloat = 20
        let smallPadding: CGFloat = 12
        
        followerImageView.setConstraints(top: view.topAnchor, topPadding: padding, left: view.leadingAnchor, leftPadding: padding, height: 90, width: 90)
        
        userNameLabel.setConstraints(top: followerImageView.topAnchor, topPadding: 0, left: followerImageView.trailingAnchor, leftPadding: smallPadding, right: view.trailingAnchor, rightPadding: -padding, height: 34)
        
        realNameLabel.setConstraints(top: userNameLabel.bottomAnchor, topPadding: 8, left: followerImageView.trailingAnchor, leftPadding: smallPadding, right: view.trailingAnchor, rightPadding: -padding, height: 20)
        
        locationView.setConstraints(left: followerImageView.trailingAnchor, leftPadding: smallPadding, bottom: followerImageView.bottomAnchor, bottomPadding: 0, height: 20)
        
        locationNameLabel.setConstraints(top: locationView.topAnchor, topPadding: 0, left: locationView.trailingAnchor, leftPadding: smallPadding, right: view.trailingAnchor, rightPadding: padding, height: 20)
        
        bioLabel.setConstraints(top: followerImageView.bottomAnchor, topPadding: smallPadding, left: followerImageView.leadingAnchor, right: view.trailingAnchor, rightPadding: padding, height: 60)
        
    }
    

}
