//
//  UsersListController.swift
//  Github-Followers
//
//  Created by Petre Vane on 07/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

//adopted by UserListCoordinator
protocol UserListCoordinatorDelegate: class {
    func userListControllerDidSelectFollower(follower: Follower)
}

class UsersListController: UIViewController {
    
 //MARK: - Initialization
    
    /// Main Section of CollectionView with Diffable Data Source
    enum Section: CaseIterable {
        case main
    }
    
    private weak var coordinator: UserListCoordinatorDelegate?
    private let networkManager = NetworkManager.sharedInstance
    private let fileManager = PersistenceManager.sharedInstance
    
    var typedUserName: String!
    var user: User?
    var unfilteredFollowers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var pageNumber = 1
    var userHasMoreFollowers = true
    var isFilteringActive = false

    // collectionView
    var collectionView: UICollectionView!
    var diffDataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureCollectionView()
        fetchFollowers(for: typedUserName, at: pageNumber)
        configureDataSource()
        configureSearchController()
    }
    
    override func viewWillAppear( _ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    /// Configure NavigationBar
    ///
    /// Configures Navigation Bar and viewController's title & background color
    func configureNavigationBar() {
        // viewCotroller
        view.backgroundColor = .systemBackground
        title = typedUserName
        
        // navigationBar
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(barButtonPressed))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func barButtonPressed() {
        if let currentFollower = self.title {
            fetchDetails(for: currentFollower)
        }
    }
    
    /// Initializes and configures the CollectionView
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: FlowLayout.configureCollectionViewFlowLayout(for: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseIdentifier)
    }
    
    /// Initializes and configures SearchBar
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a user here ..."
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
      }
    
    /// Fetches information about a given Github follower
    /// - Parameters:
    ///   - user: GitHub user for which the request is mafe
    ///   - page: page number; this is useful for a user that has multiple followers that do not fit in a single page
    func fetchFollowers(for user: String, at page: Int) {
        presentLoadingView()
        networkManager.fetchFollowers(for: user, page: pageNumber) { [weak self] result in
            
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .failure(let error):
                self.presentAlert(withTitle: "What? An error!? 😕", message: error.localizedDescription , buttonTitle: "Dismiss")
                
            case .success(let followers):
                if followers.count < 100 { self.userHasMoreFollowers = false }
                self.unfilteredFollowers.append(contentsOf: followers)
                self.updateData(with: self.unfilteredFollowers)
                if self.unfilteredFollowers.isEmpty {
                    let message = "This user has no followers yet. Go follow this user 😀"
                    DispatchQueue.main.async { self.showEmptyState(withMessage: message, view: self.view); return }
                }
            }
        }
    }
        
    /// Configures CollectionView Diffable DataSource
    func configureDataSource() {
        diffDataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseIdentifier, for: indexPath) as? FollowerCell else { return UICollectionViewCell() }
            cell.show(follower)
            return cell
        })
    }
    
    /// Updates CollectionView with data
    /// - Parameter followers: array of Follwer instances, each representing a GitHub follower
    func updateData(with followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.diffDataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    
    /// Network request for Follower details
    /// - Parameter follower: name of the follower
    ///
    /// Makes a network request aimed at getting the avatar URL for the given follower
    private func fetchDetails(for follower: String) {
        presentLoadingView()
        networkManager.fetchDetails(for: follower) { [weak self] result in 
            
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .failure(_):
                self.presentAlert(withTitle: "Error", message: "Something is not right yet...", buttonTitle: "I'll try later")
            case .success(let user):
                let follower = Follower(login: user.login, avatarURL: user.avatarURL)
                
                self.fileManager.updateFavoritesList(with: follower, updateType: .add) { [weak self] error in
                    guard let self = self else { return }
                    guard error == nil else { self.presentAlert(withTitle: "What? An error?!", message: error!.localizedDescription, buttonTitle: "Ok"); return }
                    self.presentAlert(withTitle: "Success 🥳", message: "\(user.login.capitalized) successfully added to favorites!", buttonTitle: "Cool")
                }
            }
        }
    }
}

extension UsersListController: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        // the (vertical) dimension of content that is scrolled out of screen
        let offsetY = scrollView.contentOffset.y
        // gets the total height of the content
        let contentHeight = scrollView.contentSize.height
        // gets the height of the (device)screen
        let frameHeight = scrollView.frame.size.height
        
        // difference between content shown and existing content that should be shown
        let remainingContent = contentHeight - offsetY
        
        if remainingContent < frameHeight {
        guard userHasMoreFollowers else { return }
        // reached the end of the content
            pageNumber += 1
            fetchFollowers(for: typedUserName, at: pageNumber)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let listOfFollowers = isFilteringActive ? filteredFollowers : unfilteredFollowers
        let tappedFollower = listOfFollowers[indexPath.item]
        coordinator?.userListControllerDidSelectFollower(follower: tappedFollower)
    }
}

extension UsersListController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text?.lowercased() else { return }
        guard !filter.isEmpty else { showFollowers(); return }
        isFilteringActive = true
        filteredFollowers = unfilteredFollowers.filter { $0.login.lowercased().contains(filter) }
        updateData(with: filteredFollowers)
    }
    
    /// Reloads collectionView with unfiltered followers
    private func showFollowers() {
        updateData(with: unfilteredFollowers)
        filteredFollowers.removeAll()
        isFilteringActive = false
    }
}

extension UsersListController: FollowerInfoControllerDelegate {
    
    /// Tells the delegate that the 'Get Followers' button was tapped.
    /// - Parameter user: user instance passed from FollowerInfoController
    func didRequestFollowers(for user: User) {
        updateFollowersListWithData(for: user)
    }
    
    /// Reloads UserListController with followers for the given user
    /// - Parameter user: instance of User, for which the followers should be displayed
    ///
    /// This method triggers of chain of actions, which ends up with reloading the entire collectionView with data for a given user
    private func updateFollowersListWithData(for user: User) {
        unfilteredFollowers.removeAll()
        pageNumber = 1
        updateData(with: unfilteredFollowers)
        fetchFollowers(for: user.login, at: pageNumber)
        self.title = user.login
    }
}

extension UsersListController {
    
    /// Creates an instance of itself and assigns the calling object as delegate
    /// - Parameter delegate: delegate object
    class func instantiate(parentCoordinator: UserListCoordinatorDelegate) -> UsersListController {
        let viewController = UsersListController()
        viewController.coordinator = parentCoordinator
        return viewController
    }
}
