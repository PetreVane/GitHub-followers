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
    private let fileManager = PersistenceManager.sharedInstance
    
    let tableView = UITableView()
    var tableViewCells: [Follower] = []
    
    
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

    func fetchFavorites() {
        let favorites = fileManager.retrieveSavedFollowers()
        print("You've got \(favorites.count) favorites")
        if favorites.isEmpty {
            tableView.isHidden = true
            showEmptyState(withMessage: "You've got no favorite users yet.\n Consider adding some favorites. \n 👍🏻", view: view)
        } else {
            tableView.isHidden = false
            tableViewCells = favorites
            
            DispatchQueue.main.async {
                self.view.bringSubviewToFront(self.tableView)
                self.tableView.reloadData()
            }
        }
    }
}

//MARK: - Extensions -

extension FavoritesController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.reuseIdentifier, for: indexPath) as? FavoritesCell else { return UITableViewCell() }
        let favoriteUser = tableViewCells[indexPath.row]
        cell.show(favoriteUser)
       
        return cell
    }
}

extension FavoritesController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let favoriteUser = tableViewCells[indexPath.row]
        coordinator?.presentFollowersFor(favoriteUser)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let favoriteUser = tableViewCells[indexPath.row]
        tableViewCells.remove(at: indexPath.row)
        fileManager.updateFavoritesList(with: favoriteUser, updateType: .remove) { [weak self] error in
            
            guard let self = self else { return }
            guard let error = error else { return }
            self.presentAlert(withTitle: "Ops, an error!", message: error.localizedDescription, buttonTitle: "Ok")
        }
        
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
    
}

extension FavoritesController {
    
    static func instantiate(delegate: FavoritesControllerDelegate) -> FavoritesController {
        let viewController = FavoritesController()
        viewController.delegate = delegate
        return viewController
    }
}
