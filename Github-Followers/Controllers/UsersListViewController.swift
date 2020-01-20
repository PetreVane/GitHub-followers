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
    var listOfUsers: [Follower] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureView()
        fetchFollowers(for: user, page: pageNumber)
        configureCollectionView()
        configureDataSource()

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
                self.listOfUsers.append(contentsOf: followers)
                DispatchQueue.main.async { self.updateData() }
                
                if self.listOfUsers.isEmpty {
                    let message = "This user has no followers yet. Wanna be the first one? 🤔"
                    DispatchQueue.main.async {
                        self.showEmptyState(withMessage: message, view: self.view)
                    }
                }
            }
        }
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(self.listOfUsers)
        diffDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
        
    }
    
    func configureDataSource() {
        diffDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseIdentifier, for: indexPath) as? FollowerCell else { return UICollectionViewCell() }
            
            let follower = self.listOfUsers[indexPath.item]
            cell.show(follower)

            return cell
            
        })
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
}
