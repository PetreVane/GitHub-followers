//
//  FollowerInfoController.swift
//  Github-Followers
//
//  Created by Petre Vane on 29/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit
import CustomUIElements

// adopted by UserListController (extension)
protocol FollowerInfoControllerDelegate: class {
    func didRequestFollowers(for user: User)
}
// adopted by FollowerInfoCoordinator (extension)
protocol FollowerInfoCoordinatorDelegate: class {
    func dismissView()
}

class FollowerInfoController: UIViewController {
    
    // MARK: - Properties -
    private weak var coordinator: FollowerInfoCoordinatorDelegate?
    weak var delegate: FollowerInfoControllerDelegate?
    // properties
    var gitHubFollower: Follower!
    let networkManager = NetworkManager.sharedInstance
    // views
    let scrollView = UIScrollView()
    let contentView = UIView()
    let headerViewContainer = UIView()
    let repoCardViewContainer = UIView()
    let followersCardViewContainer = UIView()
    let dateLabel = SecondaryTitleLabel(fontSize: 14)
    
    // MARK: - LifeCycle -
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        configureScrollView()
        configureCustomViews()
        fetchDetails(for: gitHubFollower)
    }
    
    // MARK: - Networking -
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
                    self.configureRepoCard(for: user, delegate: self)
                    self.configureFollowersCard(for: user, delegate: self)
                    self.setDateLabelText(withDate: user.createdAt)
                }
            }
        }
    }
    
    // MARK: - Configuration methods -
    
    /// Adds a scrollView to View & sets scrollView constraints
    private func configureScrollView() {
        view.addSubview(scrollView)
        
        // contentView needs to be embeded inside scrollView; all other elements will be embeded inside contentView
        scrollView.addSubview(contentView)
        scrollView.pinToEdgesOf(superView: view)
        contentView.pinToEdgesOf(superView: scrollView)

        // embeded contentView needs to have an explicit width and height
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    /// Sets constraints for containers (UIView objects)
    ///
    /// Each of the container object contains a child View Controller, except the dateLabel
    private func configureCustomViews() {
        dateLabel.textAlignment = .center
        dateLabel.backgroundColor = .systemBackground
        
        let padding: CGFloat = 20
        let height: CGFloat = 140
        let listOfViews = [headerViewContainer, repoCardViewContainer, followersCardViewContainer, dateLabel]

        listOfViews.forEach { customView in
            contentView.addSubview(customView)
            customView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
            ])
        }
       
        NSLayoutConstraint.activate([
            headerViewContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            headerViewContainer.heightAnchor.constraint(equalToConstant: height + 40),
            
            repoCardViewContainer.topAnchor.constraint(equalTo: headerViewContainer.bottomAnchor, constant: padding),
            repoCardViewContainer.heightAnchor.constraint(equalToConstant: height),
            
            followersCardViewContainer.topAnchor.constraint(equalTo: repoCardViewContainer.bottomAnchor, constant: padding),
            followersCardViewContainer.heightAnchor.constraint(equalToConstant: height),
            
            dateLabel.bottomAnchor.constraint(equalTo: followersCardViewContainer.bottomAnchor, constant: padding * 2),
            dateLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
        
    /// Creates an instance of RepoCard and adds it to container
    /// - Parameter user: User instance, returned by network request
    ///
    ///Adds an instance of RepoCard to its corresponding container and sets the FollowerInfoVC as delegate for RepoCard
    private func configureRepoCard(for user: User, delegate: RepoCardDelegate) {
        let repoCard = RepoCard(user: user, delegate: delegate)
        add(childVC: repoCard, to: repoCardViewContainer)
    }
    
    /// Creates an instance of FollowerCard and adds it to container
    /// - Parameter user: User instance, returned by network request
    ///
    ///Adds an instance of FollowerCard to its corresponding container and sets the FollowerInfoVC as delegate for FollowerCard
    private func configureFollowersCard(for user: User, delegate: FollowersCardDelegate) {
        let followerCard = FollowersCard(user: user, delegate: delegate)
        add(childVC: followerCard, to: followersCardViewContainer)
    }
    
    /// Adds a child ViewController to a container
    /// - Parameters:
    ///   - childVC: viewController presenting different information
    ///   - container: custom UIView containing a specific ViewController
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
    
    /// Protocol implementation: tells the delegate that the 'GitHub profile' button was tapped.
    /// - Parameter user: User instance, passed from RepoCard child viewController
    ///
    /// Triggers a chain of actions when GitHub Profile button is tapped
    func didTapProfileButton(forUser user: User) {
        let url = user.htmlURL
        openSafari(withURL: url)
    }
}

extension FollowerInfoController: FollowersCardDelegate {
    
    ///Tells the delegate that the 'Get Followers' button was tapped.
    /// - Parameter user: User instance, passed from FollwersCard
    ///
    /// Triggers a chain of actions within UserListController when 'Get Followers' button is tapped within FollowersCard
    func didTapFollowersButton(forUser user: User) {
        coordinator?.dismissView()
        delegate?.didRequestFollowers(for: user)
    }
}


extension FollowerInfoController {
    
    /// Creates an instance of itself and assigns the calling object as delegate
    /// - Parameter delegate: delegate object
    class func instantiate(parentCoordinator: FollowerInfoCoordinatorDelegate) -> FollowerInfoController {
        let viewController = FollowerInfoController()
        viewController.coordinator = parentCoordinator
        return viewController
    }
}

