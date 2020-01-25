//
//  FollowerInfoVC.swift
//  Github-Followers
//
//  Created by Petre Vane on 22/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

class FollowerInfoVC: UIViewController {
    
    let avatarImageView = AvatarImageView(frame: .zero)
    let nameLabel = TitleLabel(textAlignment: .center, fontSize: 20)
    var follower: Follower!
    let networkManager = NetworkManager.sharedInstance
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    init(follower: Follower)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        configureNavigationBar()
        configureNameLabel()
        fetchDetails(for: follower)

    }
    
    func configureNavigationBar() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissView))
        navigationItem.rightBarButtonItem = doneButton
    }
    
   @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }

    private func configureAvatar() {
        view.addSubview(avatarImageView)
    }
    
    private func configureNameLabel() {
        view.addSubview(nameLabel)
        
//        nameLabel.text = follower?.login
        nameLabel.backgroundColor = .secondarySystemBackground
        nameLabel.textColor = .systemBlue
        nameLabel.layer.cornerRadius = 10
        nameLabel.clipsToBounds = true
        nameLabel.layer.borderColor = UIColor.systemFill.cgColor
        nameLabel.layer.borderWidth = 1
        
        NSLayoutConstraint.activate([
        
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    func fetchDetails(for follower: Follower) {
        let followerName = follower.login
        networkManager.fetchDetails(for: followerName) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                print("Errors: \(error.localizedDescription)")
                
            case .success(let userDetails):
                DispatchQueue.main.async { self.nameLabel.text = "Name: \(userDetails.login) " }
                print("User details: \(userDetails.login)")
            }
        }
    }

}
