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
    enum Section {
        case main
    }
    
    var user: String!
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
        fetchFollowers(for: user, page: pageNumber)
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
    func fetchFollowers(for user: String, page: Int) {
        presentLoadingView()
//        guard userHasMoreFollowers else { return }
        
        networkManager.fetchFollowers(for: user, page: pageNumber) { [weak self] result in
            
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .failure(let error):
                self.presentAlert(withTitle: "What? An error!? 😕", message: error.localizedDescription , buttonTitle: "Dismiss")
                
            case .success(let followers):
                if followers.count < 100 { self.userHasMoreFollowers = false }
                self.unfilteredFollowers.append(contentsOf: followers)
                if self.unfilteredFollowers.isEmpty {
                    let message = "This user has no followers yet. Go follow this user 😀"
                    DispatchQueue.main.async { self.showEmptyState(withMessage: message, view: self.view); return }
                }
                 self.updateData(with: followers)
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
        DispatchQueue.main.async { self.diffDataSource.apply(snapshot, animatingDifferences: true, completion: nil) }
    }
    
}

extension UsersListViewController: UICollectionViewDelegate {
    
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
        // reached the end of the content
            pageNumber += 1
            fetchFollowers(for: user, page: pageNumber)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let listOfFollowers = isFilteringActive ? filteredFollowers : unfilteredFollowers
        let tappedFollower = listOfFollowers[indexPath.item]
        
        let destinationVC = FollowerInfoVC()
        destinationVC.follower = tappedFollower
        let navigationController = UINavigationController(rootViewController: destinationVC)
        present(navigationController, animated: true, completion: nil)
        
    }
    
}


extension UsersListViewController: UISearchResultsUpdating, UISearchBarDelegate {


    /// Updates search Result
    /// - Parameter searchController: searchController object containing the searchBar
    func updateSearchResults(for searchController: UISearchController) {

        guard let filter = searchController.searchBar.text?.lowercased() else { return }
        guard !filter.isEmpty else { return }
        filteredFollowers = unfilteredFollowers.filter({ $0.login.lowercased().contains(filter) })
        isFilteringActive = true
        updateData(with: filteredFollowers)

    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFilteringActive = false
        filteredFollowers.removeAll()
        updateData(with: unfilteredFollowers)
    }
}
