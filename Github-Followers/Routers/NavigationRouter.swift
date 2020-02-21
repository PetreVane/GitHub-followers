//
//  NavigationRouter.swift
//  Github-Followers
//
//  Created by Petre Vane on 19/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

class NavigationRouter: NSObject {
    
    // parent ViewController that will instantiate this class
    unowned var baseViewController: UIViewController?
    let navigationController = UINavigationController()
    private var onDismissForViewController: [UIViewController: (() -> Void)] = [:]
    
    override init() {
        super.init()
        // sets this class as delegate for UINavigationControllerDelegate; see Extensions
        navigationController.delegate = self
    }
}

extension NavigationRouter: Router {
    
    func present(_ viewController: UIViewController, animated: Bool, onDismiss: (() -> Void)?) {
        
        // associate the passed in closure with the passed in ViewController
        onDismissForViewController[viewController] = onDismiss
        // push the viewContolle onto the navigationController stack
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func dismiss(animated: Bool) {
        performOnDismissAction(for: navigationController.viewControllers.first!)
        baseViewController?.dismiss(animated: animated, completion: nil)
    }
    
    // MARK: - Private methods
    
    /// Presents a viewController modally
    /// - Parameters:
    ///   - viewController: ViewController to be presented
    ///   - animated: pass in true to animate the transition
    /// - adds a button (calls a method to add a button)
    /// - sets the viewController into navigationController's list of viewControllers
    /// - calls the present method of the parentVC and passes in the navigationController containg the ViewController
    private func presentModally( _ viewController: UIViewController, animated: Bool) {
        
        addCancelButton(to: viewController)
        navigationController.setViewControllers([viewController], animated: animated)
        baseViewController?.present(navigationController, animated: animated, completion: nil)
    }
    
    /// Adds a navigation bar button item
    /// - Parameter viewController: viewController that contains the button
    private func addCancelButton(to viewController: UIViewController) {
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonPressed))
    }
    
    /// Triggers an action when a button is pressed
    @objc private func cancelButtonPressed() {
        performOnDismissAction(for: navigationController.viewControllers.first!)
        baseViewController?.dismiss(animated: true, completion: nil)
    }
    
    /// Executes a closure when ViewController is dismissed
    /// - Parameter viewController: ViewController which is being dismissed
    /// - makes sure there is an associated closure for the passed in argument
    /// - executes the closure
    /// - removes the closure from dictionary
    private func performOnDismissAction(for viewController: UIViewController) {
        
        guard let onDismissAction = onDismissForViewController[viewController] else { return }
        onDismissAction()
        onDismissForViewController.removeValue(forKey: viewController)
    }
}

extension NavigationRouter: UINavigationControllerDelegate {
    
    
    /// Dismisses a viewController when the NavigationController back button is pressed
    /// - Parameters:
    ///   - navigationController: navigationController containing the ViewController that is being presented
    ///   - viewController: ViewController that is about to be dimissed
    ///   - animated: true if animations are desired
    /// - establishes which ViewController is being dismissed
    /// - makes sure the navigationController list of ViewControlled no longer contains the dismissed viewController
    /// - calls any closures for the dismissed viewController, if any
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let dismissedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        guard !navigationController.viewControllers.contains(dismissedViewController) else { return }
        performOnDismissAction(for: dismissedViewController)
    }
}
