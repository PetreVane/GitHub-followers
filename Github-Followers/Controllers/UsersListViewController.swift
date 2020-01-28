//
//  UsersListViewController.swift
//  Github-Followers
//
//  Created by Petre Vane on 07/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

class UsersListViewController: UIViewController {
    
 //MARK: - Initialization
    
    /// Main Section of CollectionView with Diffable Data Source
    enum Section: CaseIterable {
        case main
    }
    
    var currentUser: String!
    var unfilteredFollowers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var pageNumber = 1
    var userHasMoreFollowers = true
    var isFilteringActive = false
    let networkManager = NetworkManager.sharedInstance
    
    // collectionView
    var collectionView: UICollectionView!
    var diffDataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
        configureSearchController()
        configureCollectionView()
        fetchFollowers(for: currentUser, at: pageNumber)
        configureDataSource()
                
    }
    
    override func viewWillAppear( _ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    /// Configures properties of UsersListViewController
    func configureView() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    /// Initializes and configures the CollectionView
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: Helper.configureCollectionViewFlowLayout(for: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseIdentifier)

    }
    
    /// Initializes and configures SearchBar
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
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
//        print("Your list contains \(followers.count) cells")
    }
}

extension UsersListViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        // the (vertical) dimension of content that is scrolled out of screen
        let offsetY = scrollView.contentOffset.y
//        print("OffsetY is: \(offsetY)")
        // gets the total height of the content
        let contentHeight = scrollView.contentSize.height
//        print("Content height is: \(contentHeight)")
        // gets the height of the (device)screen
        let frameHeight = scrollView.frame.size.height
//        print("Frame height is: \(frameHeight)")
        // difference between content shown and existing content that should be shown
//        let remainingContent = contentHeight - offsetY
        
//        if remainingContent < frameHeight {
//        guard userHasMoreFollowers else { return }
//        // reached the end of the content
//            pageNumber += 1
//            fetchFollowers(for: currentUser, at: pageNumber)
//        }
        
        if offsetY > contentHeight - frameHeight {
            guard userHasMoreFollowers else { return }
            pageNumber += 1
            fetchFollowers(for: currentUser, at: pageNumber)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        print("You selected cell number: \(indexPath.item)")
        let listOfFollowers = isFilteringActive ? filteredFollowers : unfilteredFollowers
        let tappedFollower = listOfFollowers[indexPath.item].login
        
        let destinationVC = FollowerInfoVC()
        destinationVC.follower = tappedFollower
        let navigationController = UINavigationController(rootViewController: destinationVC)
        present(navigationController, animated: true)
    }
}


extension UsersListViewController: UISearchResultsUpdating, UISearchBarDelegate {


    /// Updates search Result
    /// - Parameter searchController: searchController object containing the searchBar
    func updateSearchResults(for searchController: UISearchController) {

        guard let filter = searchController.searchBar.text?.lowercased() else { return }
        guard !filter.isEmpty else { return }
        isFilteringActive = true
        filteredFollowers = unfilteredFollowers.filter { $0.login.lowercased().contains(filter) }
        updateData(with: filteredFollowers)

    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFilteringActive = false
        updateData(with: unfilteredFollowers)
        //        filteredFollowers.removeAll()

    }
}
