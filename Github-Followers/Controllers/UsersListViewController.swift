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
    
    var user: String = ""
    let networkManager = NetworkManager.sharedInstance
    var collectionView: UICollectionView!
    var listOfUsers: [Follower] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //
        
        configureView()
        fetchFollower()
        configureCollectionView()
        
        collectionView.dataSource = self
        collectionView.delegate = self

    }
    
    
    override func viewWillAppear( _ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    /// Initializes and configures the CollectionView
    func configureCollectionView() {
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemTeal
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseIdentifier)
        
    }
    
    /// Configures properties of UsersListViewController
    func configureView() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
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
                    self.listOfUsers.append(follower)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
}

extension UsersListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfUsers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseIdentifier, for: indexPath) as? FollowerCell else { return UICollectionViewCell() }
        
        cell.userNameLabel.text = listOfUsers[indexPath.row].login
        return cell
    }
    
    
}

extension UsersListViewController: UICollectionViewDelegate {
    
    
}
