//
//  ReusableCardView.swift
//  Github-Followers
//
//  Created by Petre Vane on 29/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

enum ContentType {
    case gist
    case repos
    case followers
    case following
}

/// UIView containing 2 labels and 1 symbol
///
/// Instances of this view are owned by ReusableCardController subclasses, such as the RepoCard.
class ReusableCardView: UIView {
    
    let symbolImage = UIImageView()
    let titleLabel = TitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = TitleLabel(textAlignment: .center, fontSize: 14)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Determines how customViews are arranged inside the ReusableCardView
    ///
    /// Sets constraints and other visual properties of all customViews included by ReusableCardView container
    private func configure() {
        
        symbolImage.contentMode = .scaleAspectFill
        symbolImage.translatesAutoresizingMaskIntoConstraints = false
        symbolImage.tintColor = .label
        titleLabel.backgroundColor = .secondarySystemBackground
        countLabel.backgroundColor = .secondarySystemBackground
        
        let visualElements = [symbolImage, titleLabel, countLabel]
        visualElements.forEach { self.addSubview($0) }
        
        
        NSLayoutConstraint.activate([
        
            symbolImage.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImage.heightAnchor.constraint(equalToConstant: 20),
            symbolImage.widthAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImage.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImage.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symbolImage.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
            
        ])
    }
    
    
    /// Sets ReusableCardView content type
    /// - Parameter contentType: enumeration of content type
    ///
    /// This method sets the content type for each of the containers presented by FollowerInfoController
    /// - Parameter count: Int representing the number of repo, gist or followers
    func set(contentType: ContentType, withCount count: Int) {
        
        switch contentType {
        case .gist:
            symbolImage.image = UIImage(systemName: SFSymbols.gist)
            titleLabel.text = "Public Gists"
        case .repos:
            symbolImage.image = UIImage(systemName: SFSymbols.repos)
            titleLabel.text = "Public Repos"
        case .followers:
            symbolImage.image = UIImage(systemName: SFSymbols.followers)
            titleLabel.text = "Followers"
        case .following:
            symbolImage.image = UIImage(systemName: SFSymbols.following)
            titleLabel.text = "Following"
        }
        
        // not sure about this
        countLabel.text = String(count)
    }
}
