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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        print("User initilized with value: \(user)")
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        fetchUsers()

    }
    
    
    override func viewWillAppear( _ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func fetchUsers() {
        networkManager.getFollowers(for: user, page: 1) { result in
            
            switch result {
            case .failure(let error):
                self.presentAlert(with: "What? An error!? 😕", message: error.localizedDescription , buttonTitle: "Dismiss")
                
            case .success(let listOfFollowers):
                for follower in listOfFollowers {
                    print("\(follower.login) follows \(self.user)")
                }
            }
        }
    }
}
