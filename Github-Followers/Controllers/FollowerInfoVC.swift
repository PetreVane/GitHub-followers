//
//  FollowerInfoVC.swift
//  Github-Followers
//
//  Created by Petre Vane on 22/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

class FollowerInfoVC: UIViewController {
    
    var follower: String!
    let networkManager = NetworkManager.sharedInstance
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        configureNavigationBar()
        fetchDetails(for: follower)

    }
    
    func configureNavigationBar() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissView))
        navigationItem.rightBarButtonItem = doneButton
    }
    
   @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }

    
    func fetchDetails(for follower: String) {

        networkManager.fetchDetails(for: follower) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                print("Errors: \(error.localizedDescription)")
                
            case .success(let user):
                print("User details: \(user.login)")
                DispatchQueue.main.async {
                    let childVC = HeaderVC(user: user)
                    self.present(childVC, animated: true)
                }
            }
        }
    }
}
