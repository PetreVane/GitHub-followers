//
//  AlertViewController.swift
//  Github-Followers
//
//  Created by Petre Vane on 08/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

/// Presents a containerView as an AlertController
class AlertViewController: UIViewController {
    
    //MARK: - Initialization
    let containerView = UIView()
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let bodyLabel = GFBodyLabel(textAlignment: .left)
    let actionButton = GFButton(backgroundColor: .systemRed, title: "Ok, let's move on")
    
    var alertTitle: String?
    var alertMessage: String?
    var buttonTitle: String?
    let padding: CGFloat = 20
    

    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.alertMessage = message
        self.buttonTitle = buttonTitle
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // white color with 75 % opacity
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureActionButton()
        configureTitleLabel()
        configureBodyLabel()
        
    }
    
    //MARK:- ContainerView
    
    /// Sets container constraints & visual attributes, such as background color and corner radius
    func configureContainerView() {
        view.addSubview(containerView)
        
        // containerView attributes
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 15
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.tertiarySystemBackground.cgColor
        containerView.layer.backgroundColor = UIColor.systemBackground.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // containerView constraints
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 280),
            containerView.widthAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    
    //MARK:- Title Label
    
    /// Adds a label to containerView and sets constraints & text
    func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        // titleLabel constraints
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    
    //MARK:- Action Button
    
    /// Adds a button to containerView and sets title, action & constraints
    func configureActionButton() {
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
        
        // actionButton constraints
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
            
        ])
    }
    
    
    //MARK:- Body Label
    
    /// Adds a secondary label (bodyLabel) to containerView and sets text & constraints
    func configureBodyLabel() {
        containerView.addSubview(bodyLabel)
        bodyLabel.text = alertMessage ?? "Unable to complete request"
        bodyLabel.numberOfLines = 4
        
        // bodyLabel constraints
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            bodyLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: 12),
            bodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding)
        ])
        
    }
    
    //MARK:- Target action
    
    /// Dismisses the alert controller
    @objc func actionButtonPressed() {
        print("Action button pressed")
        dismiss(animated: true, completion: nil)
    }
    
}
