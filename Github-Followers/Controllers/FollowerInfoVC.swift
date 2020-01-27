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
    let headerView = UIView()
    
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
        configureHeaderView()
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
                DispatchQueue.main.async {
                    self.add(childVC: HeaderVC(user: user), to: self.headerView)
                }
            }
        }
    }
    
    func configureHeaderView() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
        
    }
    
    func add(childVC: UIViewController, to container: UIView) {
        self.addChild(childVC)
        container.addSubview(childVC.view)
        childVC.view.frame = container.bounds
        childVC.didMove(toParent: self)
    }
    
}
