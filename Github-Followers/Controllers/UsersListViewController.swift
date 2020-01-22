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
    
    enum Section {
        case main
    }
    
    var user: String = ""
    var pageNumber = 1
    var userHasMoreFollowers = true
    let networkManager = NetworkManager.sharedInstance
    var collectionView: UICollectionView!
    var diffDataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var listOfFollowers: [Follower] = []
    var sortedFollowers: [Follower] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
        configureSearchController()
        configureCollectionView()
        fetchFollowers(for: user, page: pageNumber)
        configureDataSource()
        configureSearchController()
        

    }
    
    
    override func viewWillAppear( _ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    deinit {
        print("View has been deinitialized")
    }
    
    
    /// Initializes and configures the CollectionView
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: Helper.configureCollectionViewFlowLayout(for: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseIdentifier)
        
    }
    

    
    /// Configures properties of UsersListViewController
    func configureView() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    /// Fetches information about a given Github follower
    func fetchFollowers(for user: String, page: Int) {

        presentLoadingView()
        guard userHasMoreFollowers else { return }
        
        networkManager.fetchFollowers(for: user, page: pageNumber) { [weak self] result in
            
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
                
            case .failure(let error):
                self.presentAlert(withTitle: "What? An error!? 😕", message: error.localizedDescription , buttonTitle: "Dismiss")
                
            case .success(let followers):
                if followers.count < 100 { self.userHasMoreFollowers = false }
                self.listOfFollowers.append(contentsOf: followers)
                DispatchQueue.main.async { self.updateData(with: followers) }
                
                if self.listOfFollowers.isEmpty {
                    let message = "This user has no followers yet. Go follow this user 😀"
                    DispatchQueue.main.async {
                        self.showEmptyState(withMessage: message, view: self.view)
                    }
                }
            }
        }
    }
    
    func updateData(with followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        diffDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
        
    }
    
    func configureDataSource() {
        diffDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseIdentifier, for: indexPath) as? FollowerCell else { return UICollectionViewCell() }
            
            let follower = self.listOfFollowers[indexPath.item]
            cell.show(follower)

            return cell
            
        })
    }
    
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a user here ..."
        navigationItem.searchController = searchController
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
        print("Cell at indexPath \(indexPath) has been tapped   ")
    }
}

extension UsersListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
   
        guard let filter = searchController.searchBar.text?.lowercased() else { return }
        if filter.isEmpty {
            updateData(with: listOfFollowers)
        } else {
            sortedFollowers = listOfFollowers.filter({ follower -> Bool in
                return follower.login.lowercased().contains(filter)
            })

            updateData(with: sortedFollowers)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        sortedFollowers.removeAll()
        updateData(with: listOfFollowers)
    }
    
    
}
