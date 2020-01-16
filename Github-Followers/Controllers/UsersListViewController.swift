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
    let networkManager = NetworkManager.sharedInstance
    var collectionView: UICollectionView!
    var diffDataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var listOfUsers: [Follower] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureView()
        fetchFollower()
        configureCollectionView()
        configureDataSource()
        
    }
    
    
    override func viewWillAppear( _ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    /// Initializes and configures the CollectionView
    func configureCollectionView() {
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: Helper.configureCollectionViewFlowLayout(for: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseIdentifier)
        
    }
    

    
    /// Configures properties of UsersListViewController
    func configureView() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureDataSource() {
        diffDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseIdentifier, for: indexPath) as? FollowerCell else { return UICollectionViewCell() }
            cell.userNameLabel.text = self.listOfUsers[indexPath.item].login
            
            return cell
            
        })
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(self.listOfUsers)
        diffDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
        
    }
    /// Fetches information about a given Github follower
    func fetchFollower() {
        networkManager.getFollowers(for: user, page: 1) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                self.presentAlert(with: "What? An error!? 😕", message: error.localizedDescription , buttonTitle: "Dismiss")
                
            case .success(let listOfFollowers):
                for follower in listOfFollowers {
                    print("\(follower.login) follows \(self.user)")
                    self.listOfUsers = listOfFollowers
                    DispatchQueue.main.async { self.updateData() }
                }
            }
        }
    }
}
