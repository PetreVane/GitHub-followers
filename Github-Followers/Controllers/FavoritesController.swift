//
//  FavoritesController.swift
//  Github-Followers
//
//  Created by Petre Vane on 02/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

protocol FavoritesControllerDelegate: class {
    
}

class FavoritesController: UIViewController {

     //MARK: - Initialization -
    
    // delegates
    private weak var delegate: FavoritesControllerDelegate?
    weak var coordinator: FavoritesCoordinator?
    
    //managers
    private let userDefaults = PersistenceManager.sharedInstance
    private let networkManager = NetworkManager.sharedInstance
    private let cacheManager = CacheManager.sharedInstance
    
    let tableView = UITableView()
    var tableViewCells: [IndexPath: FavoritesCell] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureView()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavorites()
    }
    
    //MARK: - Configuration -

    
    private func configureView() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        coordinator?.setNavigationBarLargeTitle()
    }

    func fetchFavorites() -> [Follower]? {
        let favorites = userDefaults.retrieveSavedFollowers()
        print("You've got \(favorites.count) favorites")
        if favorites.isEmpty {
            tableView.isHidden = true
            showEmptyState(withMessage: "You've got no favorite users yet.\n Consider adding some favorites. \n 👍🏻", view: view); return nil
        }
        fetchAvatarsFor(favorites)
        return favorites
    }
    
    func fetchAvatarsFor(_ favoriteFollowers:[Follower]) {
        let favorites = favoriteFollowers
        
        for (index, favorite) in favorites.enumerated() {
            print("Favorite \(favorite.login) resides at index \(index)")
        }
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        
        // register cell
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.reuseIdentifier)
    }
}

//MARK: - Extensions -

extension FavoritesController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.reuseIdentifier) as? FavoritesCell else { return UITableViewCell() }
//        let favoriteUser = tableViewCells[indexPath.row]
//        cell.avatarImageView.image = favoriteUser.avatarImageView.image
//        cell.userNameLabel.text = favoriteUser.userNameLabel.text
        
        return cell
    }
}

extension FavoritesController: UITableViewDelegate {
    
    
}

extension FavoritesController {
    
    static func instantiate(delegate: FavoritesControllerDelegate) -> FavoritesController {
        let viewController = FavoritesController()
        viewController.delegate = delegate
        return viewController
    }
}
