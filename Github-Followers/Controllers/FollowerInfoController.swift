//
//  FollowerInfoController.swift
//  Github-Followers
//
//  Created by Petre Vane on 29/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//


import UIKit

class FollowerInfoController: UIViewController {
    
    var githubUser: Follower!
    let networkManager = NetworkManager.sharedInstance
    let headerViewContainer = UIView()
    let repoCardViewContainer = UIView()
    let followersCardViewContainer = UIView()
    let dateLabel = SecondaryTitleLabel(fontSize: 14)
   
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureCustomViews()
        fetchDetails(for: githubUser)
    }
    
    
    /// Adds visual properties to Navigation Bar
    ///
    ///Adds a button to Navigation Bar and setts the background color
    private func configureNavigationBar() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissView))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    /// Dismisses the current view
    ///
    /// Returns the user back to original screen
   @objc private func dismissView() {
        dismiss(animated: true, completion: nil)
    }

    
    /// Fetches information about a given user
    /// - Parameter follower: GitHub follwer name
    ///
    /// Makes a network request asking for more information about specific user
    func fetchDetails(for follower: Follower) {
        let GHUser = follower.login
        networkManager.fetchDetails(for: GHUser) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                self.presentAlert(withTitle: "Something went wrong...", message: error.localizedDescription, buttonTitle: "Dismiss")
                
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: HeaderCard(user: user), to: self.headerViewContainer)
                    self.prepareRepoCard(for: user)
                    self.prepareFollowersCard(for: user)
                    self.setDateLabelText(withDate: user.createdAt)
                }
            }
        }
    }
    
    
    /// Sets constraints for containers (UIView objects)
    ///
    /// Each of the container object contains a child View Controller, except the dateLabel
    private func configureCustomViews() {
        
        // label configuration
        dateLabel.textAlignment = .center
        dateLabel.backgroundColor = .systemBackground
        
        // constrain properties
        let padding: CGFloat = 20
        let height: CGFloat = 140
        
        // custom views list
        let listOfViews = [headerViewContainer, repoCardViewContainer, followersCardViewContainer, dateLabel]

        listOfViews.forEach { customView in
            view.addSubview(customView)
            customView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                customView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding), 
                customView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
       
        NSLayoutConstraint.activate([
            headerViewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            headerViewContainer.heightAnchor.constraint(equalToConstant: height + 40),
            
            repoCardViewContainer.topAnchor.constraint(equalTo: headerViewContainer.bottomAnchor, constant: padding),
            repoCardViewContainer.heightAnchor.constraint(equalToConstant: height),
            
            followersCardViewContainer.topAnchor.constraint(equalTo: repoCardViewContainer.bottomAnchor, constant: padding),
            followersCardViewContainer.heightAnchor.constraint(equalToConstant: height),
            
            dateLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
    /// Creates an instance of RepoCard and adds it to container
    /// - Parameter user: User instance, returned by network request
    ///
    ///Adds an instance of RepoCard to its corresponding container and sets the FollowerInfoVC as delegate for RepoCard
    private func prepareRepoCard(for user: User) {
        let repoCard = RepoCard(user: user)
        repoCard.delegate = self
        add(childVC: repoCard, to: repoCardViewContainer)
    }
    
    
    /// Creates an instance of FollowerCard and adds it to container
    /// - Parameter user: User instance, returned by network request
    ///
    ///Adds an instance of FollowerCard to its corresponding container and sets the FollowerInfoVC as delegate for FollowerCard
    private func prepareFollowersCard(for user: User) {
        let followerCard = FollowersCard(user: user)
        followerCard.delegate = self
        add(childVC: followerCard, to: followersCardViewContainer)
    }
    
    
    /// Adds a child ViewController to a container
    /// - Parameters:
    ///   - childVC: viewController presenting different information
    ///   - container: custom UIView containing a specific ViewController
    ///
    func add(childVC: UIViewController, to container: UIView) {
        addChild(childVC)
        container.addSubview(childVC.view)
        childVC.view.frame = container.bounds
        childVC.didMove(toParent: self)
    }
    
    
    /// Adds Date to DateLabel
    /// - Parameter date: date at which the GitHub account has been created
    ///
    /// Date is formated and added to DateLabel text property
    func setDateLabelText(withDate date: Date) {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MMMM yyyy"
        let date = dateFormater.string(from: date)
        dateLabel.text = "On Github since \(date)"
    }
}


extension FollowerInfoController: RepoCardDelegate {
    
    /// Protocol implementation
    /// - Parameter user: User instance, returned by network request
    ///
    /// Triggers a chain of actions when GitHub Profile button is tapped
    func didTapProfileButton(forUser user: User) {
        print("Profile Button for user \(user.login) has been tapped")
    }
}

extension FollowerInfoController: FollowersCardDelegate {
    
    /// Protocol implementation
    /// - Parameter user: User instance, returned by network request
    ///
    /// Triggers a chain of actions when Get Followers button is tapped
    func didTapFollowersButton(forUser user: User) {
        print("Followers button has been tapped for user \(user.login)")
    }
}
