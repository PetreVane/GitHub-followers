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
    let subHeaderView = UIView()
    let middleView = UIView()
    
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
        configureCustomViews()
        fetchDetails(for: follower)
    }
    
    /// Adds visual properties to Navigation Bar
    ///
    ///Adds a button to Navigation Bar and setts the background color
    func configureNavigationBar() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissView))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    /// Dismisses the current view
    ///
    /// Returns the user back to original screen
   @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }

    
    /// Downloads information about a given user
    /// - Parameter follower: GitHub follwer name
    ///
    /// Makes a network request asking for more information about specific user
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
    
    /// Sets constraints for custom UIViews objects
    ///
    /// Each of the custom UIView object contains a child View Controller
    func configureCustomViews() {
        
        subHeaderView.backgroundColor = .systemBlue
        middleView.backgroundColor = .systemRed
        let padding: CGFloat = 20
        let height: CGFloat = 180
        let listOfViews = [headerView, subHeaderView, middleView]

        listOfViews.forEach { customView in
            view.addSubview(customView)
            customView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
            
                customView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                customView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])

        }
       
                
        NSLayoutConstraint.activate([
        
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            headerView.heightAnchor.constraint(equalToConstant: height),
            
            subHeaderView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            subHeaderView.heightAnchor.constraint(equalToConstant: height),
            
            middleView.topAnchor.constraint(equalTo: subHeaderView.bottomAnchor, constant: padding),
            middleView.heightAnchor.constraint(equalToConstant: height)
        ])
        
    }
    
    /// Adds a child ViewController to a container
    /// - Parameters:
    ///   - childVC: viewController presenting different information
    ///   - container: custom UIView containing a specific ViewController
    ///
    func add(childVC: UIViewController, to container: UIView) {
        self.addChild(childVC)
        container.addSubview(childVC.view)
        childVC.view.frame = container.bounds
        childVC.didMove(toParent: self)
    }
    
}
