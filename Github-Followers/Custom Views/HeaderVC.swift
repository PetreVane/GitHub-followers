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
        
        let listOfElements = [followerImageView, userNameLabel,
                              realNameLabel, locationNameLabel,
                              locationView, bioLabel]
        
        listOfElements.forEach { customView in
            view.addSubview(customView)
            customView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    /// Sets constraints for ViewController objects
    func setConstraints() {
        
        let padding: CGFloat = 20
        let smallPadding: CGFloat = 10
        
        NSLayoutConstraint.activate([
        
            followerImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            followerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            followerImageView.heightAnchor.constraint(equalToConstant: 90),
            followerImageView.widthAnchor.constraint(equalToConstant: 90),
            
            userNameLabel.topAnchor.constraint(equalTo: followerImageView.topAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: followerImageView.trailingAnchor, constant: smallPadding),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            userNameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            realNameLabel.centerYAnchor.constraint(equalTo: followerImageView.centerYAnchor, constant: smallPadding - 2),
            realNameLabel.leadingAnchor.constraint(equalTo: followerImageView.trailingAnchor, constant: smallPadding),
            realNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            realNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationView.bottomAnchor.constraint(equalTo: followerImageView.bottomAnchor),
            locationView.leadingAnchor.constraint(equalTo: followerImageView.trailingAnchor, constant: smallPadding),
            locationView.heightAnchor.constraint(equalToConstant: 20),
            locationView.widthAnchor.constraint(equalToConstant: 20),
            
            locationNameLabel.centerYAnchor.constraint(equalTo: locationView.centerYAnchor),
            locationNameLabel.leadingAnchor.constraint(equalTo: locationView.trailingAnchor, constant: smallPadding / 2),
            locationNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            locationNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: followerImageView.bottomAnchor, constant: smallPadding),
            bioLabel.leadingAnchor.constraint(equalTo: followerImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        
        ])
        
//        followerImageView.setConstraints(top: view.topAnchor, topPadding: padding, left: view.leadingAnchor, leftPadding: padding, height: 90, width: 90)
//
//        userNameLabel.setConstraints(top: followerImageView.topAnchor, topPadding: 0, left: followerImageView.trailingAnchor, leftPadding: smallPadding, right: view.trailingAnchor, rightPadding: -padding, height: 34) //  consider 38
//
//        realNameLabel.setConstraints(top: userNameLabel.bottomAnchor, topPadding: 8, left: followerImageView.trailingAnchor, leftPadding: smallPadding, right: view.trailingAnchor, rightPadding: -padding, height: 20)
//
//        locationView.setConstraints(left: followerImageView.trailingAnchor, leftPadding: smallPadding, bottom: followerImageView.bottomAnchor, bottomPadding: 0, height: 20, width: 20)
//
//        locationNameLabel.setConstraints(top: locationView.topAnchor, topPadding: 0, left: locationView.trailingAnchor, leftPadding: 5, right: view.trailingAnchor, rightPadding: -padding, height: 20, width: 20)
//
//        bioLabel.setConstraints(top: followerImageView.bottomAnchor, topPadding: smallPadding, left: followerImageView.leadingAnchor, right: view.trailingAnchor, rightPadding: padding, height: 60)
//
    }
    
    func configureUIElements(for user: User) {
        NetworkManager.sharedInstance.fetchAvatars(from: user.avatarURL) { avatar in
            DispatchQueue.main.async {
                self.followerImageView.image = avatar
            }
            
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
