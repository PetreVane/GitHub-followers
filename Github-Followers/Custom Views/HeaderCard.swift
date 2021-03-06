//
//  HeaderCard.swift
//  Github-Followers
//
//  Created by Petre Vane on 25/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit
import CustomUIElements

/// Card like ViewController presented by FollowerInfoController
///
/// This card like ViewController is presented by FollowerInfoController when the user taps a follower cell.
/// Similarly to ReusableCardView, this header view contains a rounded image and several labels.
class HeaderCard: UIViewController {

    let followerImageView = AvatarImageView(frame: .zero)
    var userNameLabel = TitleLabel(textAlignment: .left, fontSize: 20)
    var realNameLabel = SecondaryTitleLabel(fontSize: 15)
    let bioLabel = BodyLabel(textAlignment: .left)
    
    let locationView = UIImageView()
    let locationNameLabel = SecondaryTitleLabel(fontSize: 10)
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureUIElements(for: user)
        setConstraints()
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
        let customViews = [followerImageView, userNameLabel, realNameLabel, locationNameLabel, locationView, bioLabel]
        locationView.translatesAutoresizingMaskIntoConstraints = false
        
        customViews.forEach { customView in
            view.addSubview(customView)
        }
    }
    
    /// Sets constraints for ViewController objects
    func setConstraints() {
        
        let padding: CGFloat = 20
        let smallPadding: CGFloat = 10
        
        NSLayoutConstraint.activate([
        
            followerImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            followerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            followerImageView.heightAnchor.constraint(equalToConstant: 90),
            followerImageView.widthAnchor.constraint(equalToConstant: 90),
            
            userNameLabel.topAnchor.constraint(equalTo: followerImageView.topAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: followerImageView.trailingAnchor, constant: smallPadding),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userNameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            realNameLabel.centerYAnchor.constraint(equalTo: followerImageView.centerYAnchor, constant: smallPadding - 2),
            realNameLabel.leadingAnchor.constraint(equalTo: followerImageView.trailingAnchor, constant: smallPadding),
            realNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            realNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationView.bottomAnchor.constraint(equalTo: followerImageView.bottomAnchor),
            locationView.leadingAnchor.constraint(equalTo: followerImageView.trailingAnchor, constant: smallPadding),
            locationView.heightAnchor.constraint(equalToConstant: 20),
            locationView.widthAnchor.constraint(equalToConstant: 20),
            
            locationNameLabel.centerYAnchor.constraint(equalTo: locationView.centerYAnchor),
            locationNameLabel.leadingAnchor.constraint(equalTo: locationView.trailingAnchor, constant: smallPadding / 2),
            locationNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: followerImageView.bottomAnchor, constant: smallPadding),
            bioLabel.leadingAnchor.constraint(equalTo: followerImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 80)
        
        ])

    }
    
    /// Prepares subviews to be displayed with user data
    /// - Parameter user: user object 
    func configureUIElements(for user: User) {
        
        NetworkManager.sharedInstance.fetchAvatars(from: user.avatarURL) { avatar in
            DispatchQueue.main.async { self.followerImageView.image = avatar }
        }
        userNameLabel.text = user.login
        realNameLabel.text = user.name ?? "Name not available"
        realNameLabel.backgroundColor = .systemBackground
        locationView.image = UIImage(systemName: SFSymbols.location)
        locationView.tintColor = .secondaryLabel
        locationNameLabel.text = user.location ?? "Location not specified"
        locationNameLabel.backgroundColor = .systemBackground
        bioLabel.text = user.bio ?? "User has no bio"
        bioLabel.numberOfLines = 3
    }
}
