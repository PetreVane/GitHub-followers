//
//  UIViewController+Ext.swift
//  Github-Followers
//
//  Created by Petre Vane on 08/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit
import SafariServices


fileprivate var containerView: UIView!

extension UIViewController {
    
    /// Shows an alert to the user
    /// - Parameters:
    ///   - title: represents the alert title
    ///   - message: message contained by the alert
    ///   - buttonTitle: text contained by the button
    func presentAlert(withTitle title: String, message: String, buttonTitle: String) {
    
        DispatchQueue.main.async {
            let alert = AlertViewController(title: title, message: message, buttonTitle: buttonTitle)
            alert.modalPresentationStyle = .overFullScreen
            alert.modalTransitionStyle = .crossDissolve
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    /// Adds a view which contains an Activity Indicator
    func presentLoadingView() {

        // sets containerView to match the size of the view
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)

        // custom settings
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0 // transparent

        // animating background fadding
        UIView.animate(withDuration: 0.3) { containerView.alpha = 0.8 }


        // activity indicator
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        //  activity indicator constraints
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            ])

        // starting the activity indicator
        activityIndicator.startAnimating()
    }
    
    
    /// Dismisses the view containing an Activity Indicator
    func dismissLoadingView() {
        
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    
    /// Adds an EmptyState view to calling ViewController
    /// - Parameters:
    ///   - message: text passed to EmptyState label
    ///   - view: ViewController from which the EmptyState is called
    func showEmptyState(withMessage message: String, view: UIView) {
        // init emptyState
        let emptyState = EmptyState(message: message)
        // establish the frame size
        emptyState.frame = view.bounds
        // adds the emptyState view to viewController
        view.addSubview(emptyState)
    }
    
    
    /// Opens an URL into Safari
    /// - Parameter stringURL: URL (as String) that should be opened
    func openSafari(withURL stringURL: String) {
        
        guard let url = URL(string: stringURL) else { presentAlert(withTitle: "Ops, an error", message: "The url you're trying to open is invalid", buttonTitle: "Ok"); return }
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemIndigo
        present(safariVC, animated: true)
    }
}
