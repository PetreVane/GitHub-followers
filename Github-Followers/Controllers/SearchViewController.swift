//
//  SearchViewController.swift
//  Github-Followers
//
//  Created by Petre Vane on 02/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
     //MARK: - Initialization
    
    let logoImageView = UIImageView()
    let userNameTextField = GFTextField()
    let followButton = GFButton(backgroundColor: .systemGreen, title: "Show followers")
    var isUserNameEntered: Bool {
        return userNameTextField.text!.isEmpty ? false : true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        configureLogoView()
        configureTextField()
        configureFollowButton()
        dismissKeyboardGesture()
        
        //delegates
        userNameTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
     //MARK: - Logo View
    
    /// Adds image & sets imageView constraints
    func configureLogoView() {
        // autoLayout
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // adds image view
        view.addSubview(logoImageView)
        logoImageView.image = UIImage(named: "gh-logo")
        
        // sets constraints
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
     //MARK: - TextField
    
    /// Sets textField constraints
    func configureTextField() {
        // adds textField to view
        view.addSubview(userNameTextField)
        
        // sets constraints
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
     //MARK: - Button
    
    ///Sets button constraints
    func configureFollowButton() {
        view.addSubview(followButton)
        
        // sets constraints
        NSLayoutConstraint.activate([
            followButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            followButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            followButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            followButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        //add target
        followButton.addTarget(self, action: #selector(pushUserListVC), for: .touchUpInside)
    }
    
    /// Keyboard dissmis
    func dismissKeyboardGesture() {
        
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func pushUserListVC() {
       
        guard isUserNameEntered else { presentAlert(with: "Empty username", message: "Please enter someone's unsername. We need to know who to look for 🧐", buttonTitle: "Dismiss"); return }
        let followersVC = UsersListViewController()
        followersVC.user = userNameTextField.text!
        followersVC.title = userNameTextField.text!
        navigationController?.pushViewController(followersVC, animated: true)
        
        // dismisses the keyboard before transition
        self.view.endEditing(true)
    }
    
}

 //MARK: - TextField Delegate methods

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        pushUserListVC()
        return true
    }

}