//
//  SearchController.swift
//  Github-Followers
//
//  Created by Petre Vane on 02/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

protocol SearchControllerDelegate: class {
    func searchControllerDidPressSearchButton(_ viewController: SearchController, withText text: String)
}

class SearchController: UIViewController {
    
     //MARK: - Initialization
    weak var delegate: SearchControllerDelegate?
    let logoImageView = UIImageView()
    let userNameTextField = TextField()
    let followButton = CustomButton(backgroundColor: .systemGreen, title: "Show followers")
    var isUserNameEntered: Bool {
        return userNameTextField.text!.isEmpty ? false : true
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        print("SearchController has been init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        // have a gesture
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        // adds gesture to view
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func pushUserListVC() {
       
        guard isUserNameEntered else { presentAlert(withTitle: "Empty username", message: "Please enter someone's unsername. We need to know who to look for 🧐", buttonTitle: "Dismiss"); return }
        print("Button pressed")

        // test
        if let userTypedText = userNameTextField.text {
            delegate?.searchControllerDidPressSearchButton(self, withText: userTypedText)
        }
                
//        let followersVC = UsersListController()
//        followersVC.typedUserName = userNameTextField.text!
        
        // dismisses the keyboard before transition
        self.view.endEditing(true)
//        userNameTextField.text = nil
    }
}

 //MARK: - TextField Delegate methods

extension SearchController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        pushUserListVC()
        return true
    }
}


extension SearchController {
    class func instantiate(delegate: SearchControllerDelegate) -> SearchController {
        let viewController = SearchController()
        viewController.delegate = delegate
        return viewController
    }
}
