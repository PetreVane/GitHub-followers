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
            reloadVisibleCells()
        }
    }
    
    func reloadVisibleCells() {
        if let indexOfVisibleCells = tableView.indexPathsForVisibleRows {
            DispatchQueue.main.async {
                self.tableView.reloadRows(at: indexOfVisibleCells, with: .fade)
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
    }
    
}

extension FavoritesController {
    
    static func instantiate(delegate: FavoritesControllerDelegate) -> FavoritesController {
        let viewController = FavoritesController()
        viewController.delegate = delegate
        return viewController
    }
}
