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
    let firstView = ReusableView()
    let secondView = ReusableView()
    let actionButton = CustomButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureCardView()
        configureCustomViews()
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
        stackView.distribution = .fillEqually // try .equalSpacing
        
        stackView.addArrangedSubview(firstView)
        stackView.addArrangedSubview(secondView)
        
    }
    
    /// Sets constraints and visual properties of custom Views
    ///
    /// Adds views to stackView and determines how views are presented
    private func configureCustomViews() {
        
        let padding: CGFloat = 20
        let listOfViews = [stackView, actionButton]
        
        listOfViews.forEach { customView in
            view.addSubview(customView)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
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
