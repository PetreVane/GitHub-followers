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
    
    private weak var delegate: FavoritesControllerDelegate?
    weak var coordinator: FavoritesCoordinator?
    let tableView = UITableView()
    private let userDefaults = PersistenceManager.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        coordinator?.setNavigationBarLargeTitle()
        
    }

    func fetchFavorites() {
        let favorites = userDefaults.retrieveFavorites()
        
    }
}


extension FavoritesController {
    
    static func instantiate(delegate: FavoritesControllerDelegate) -> FavoritesController {
        let viewController = FavoritesController()
        viewController.delegate = delegate
        return viewController
    }
}
