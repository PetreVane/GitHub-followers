//
//  SearchController.swift
//  Github-Followers
//
//  Created by Petre Vane on 02/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

protocol SearchControllerCoordinatorDelegate: class {
    func searchControllerDidPressSearchButton(_ viewController: SearchController, withText text: String)
}

class SearchController: UIViewController {
    
     //MARK: - Initialization
    private weak var coordinator: SearchControllerCoordinatorDelegate?
    let logoImageView = UIImageView()
    let userNameTextField = TextField()
    let followButton = CustomButton(backgroundColor: .systemIndigo, title: "Show followers")
    var isUserNameEntered: Bool {
        return userNameTextField.text!.isEmpty ? false : true
    }

    init() {
        super.init(nibName: nil, bundle: nil)
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
        followButton.addTarget(self, action: #selector(didPressSearchButton), for: .touchUpInside)
    }
    
    /// Keyboard dissmis
    func dismissKeyboardGesture() {
        // have a gesture
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        // adds gesture to view
        view.addGestureRecognizer(tapGesture)
    }
    
    // didPressSearchButton informs its delegate
    @objc func didPressSearchButton() {

        guard isUserNameEntered else { presentAlert(withTitle: "Empty username", message: "Please enter someone's unsername. We need to know who to look for 🧐", buttonTitle: "Dismiss"); return }

        if let userTypedText = userNameTextField.text {
            coordinator?.searchControllerDidPressSearchButton(self, withText: userTypedText)
        }
                        
        // dismisses the keyboard before transition
        self.view.endEditing(true)
        userNameTextField.text = nil
    }
}

 //MARK: - TextField Delegate methods

extension SearchController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didPressSearchButton()
        return true
    }
}


extension SearchController {
    
    /// Creates an instance of itself and assigns the calling object as delegate
    /// - Parameter delegate: delegate object
    class func instantiate(parentCoordinator: SearchControllerCoordinatorDelegate) -> SearchController {
        let viewController = SearchController()
        viewController.coordinator = parentCoordinator
        return viewController
    }
}
