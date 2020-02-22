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
    
    private weak var coordinator: FavoritesControllerDelegate?
    let tableView = UITableView()
    
    private let storage = PersistenceManager.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemTeal
//        fetchFavorites()
    }
    

    func fetchFavorites() {
       let favorites = storage.retrieveFavorites()
        print(favorites)
    }
}


extension FavoritesController {
    
    static func instantiate(parentCoordinator: FavoritesControllerDelegate) -> FavoritesController {
        let viewController = FavoritesController()
        viewController.coordinator = parentCoordinator
        return viewController
    }
}
