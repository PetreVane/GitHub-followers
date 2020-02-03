//
//  ReusableCardController.swift
//  Github-Followers
//
//  Created by Petre Vane on 29/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

class ReusableCardController: UIViewController {
    
    let stackView = UIStackView()
    let firstView = ReusableCardView()
    let secondView = ReusableCardView()
    let actionButton = CustomButton()
    
    var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureCardView()
        layoutCustomViews()
        configureStackView()
    }
    
    /// Sets ReusableCardController object visual properties
    ///
    /// Sets the background color and the corner radius
    private func configureCardView() {
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 12.5
    }
    
    /// Determines what stackView contains and how is presented
    private func configureStackView() {
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(firstView)
        stackView.addArrangedSubview(secondView)
    }
    
    /// Sets constraints and visual properties of custom Views
    ///
    /// Adds views to stackView and determines how views are presented
    private func layoutCustomViews() {
        
        let padding: CGFloat = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let listOfViews = [stackView, actionButton]
        listOfViews.forEach { view.addSubview($0) }

        
        NSLayoutConstraint.activate([
        
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
