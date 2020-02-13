//
//  FavoritesController.swift
//  Github-Followers
//
//  Created by Petre Vane on 02/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

class FavoritesController: UIViewController {

     //MARK: - Initialization -
    
    weak var childCoordinator: FavoritesCoordinator?
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
