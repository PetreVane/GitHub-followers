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
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var listOfUsers: [Follower] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureView()
        fetchFollower()
        configureCollectionView()
        configureDataSource()
        
//        collectionView.dataSource = self
//        collectionView.delegate = self

    }
    
    
    override func viewWillAppear( _ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    /// Initializes and configures the CollectionView
    func configureCollectionView() {
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: configureCollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseIdentifier)
        
    }
    
    
    func configureCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        
        let flowLayout = UICollectionViewFlowLayout()
        // gets the width of the screen
        let width = view.bounds.width
        // adds some leading & trailing padding
        let padding: CGFloat = 12
        let distanceBetweenItems: CGFloat = 10
        // the total available width for cells
        let availableWidth = width - (padding * 2) - (distanceBetweenItems * 2)
        // size of 1 cell
        let itemWidth = availableWidth / 3
        // assigns padding to layout
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        //assigns item size as CGSize
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 35)
                
        return flowLayout
    }
    
    /// Configures properties of UsersListViewController
    func configureView() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseIdentifier, for: indexPath) as? FollowerCell else { return UICollectionViewCell() }
            cell.userNameLabel.text = self.listOfUsers[indexPath.item].login
            
            return cell
            
        })
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(self.listOfUsers)
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
        
    }
    /// Fetches information about a given Github follower
    func fetchFollower() {
        networkManager.getFollowers(for: user, page: 1) { result in
            
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
