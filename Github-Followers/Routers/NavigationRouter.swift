//
//  NavigationRouter.swift
//  Github-Followers
//
//  Created by Petre Vane on 19/02/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

class NavigationRouter: NSObject {
    
    // base ViewController used by presetModally()
    unowned var baseViewController: UIViewController?
    var navigationController = UINavigationController()
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
        
        // calls presentModally, if there is a new instance of NavigationRouter, which has the 'baseViewController' set.
        if baseViewController != nil {
            presentModally(viewController, animated: true)
        } else {
             // else push the viewContolle onto the navigationController stack
            navigationController.pushViewController(viewController, animated: true)
        }               
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
    func presentModally( _ viewController: UIViewController, animated: Bool) {
        addCancelButton(to: viewController)
        navigationController.setViewControllers([viewController], animated: animated)
        baseViewController?.present(navigationController, animated: animated, completion: nil)
    }
    
    /// Adds a navigation bar button item
    /// - Parameter viewController: viewController that contains the button
    private func addCancelButton(to viewController: UIViewController) {
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonPressed))
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
    /// - removes the closure from dictionary and cancel the association between ViewController and closure
    func performOnDismissAction(for viewController: UIViewController) {
        guard let onDismissAction = onDismissForViewController[viewController] else { return }
        onDismissAction()
        onDismissForViewController.removeValue(forKey: viewController)
    }
}


extension NavigationRouter: UINavigationControllerDelegate {
    
    /// Called just after the navigation controller displays a view controller’s view and navigation item properties.
    /// - Parameters:
    ///   - navigationController: The navigation controller that is showing the view and properties of a view controller.
    ///   - viewController: The view controller whose view and navigation item properties are being shown.
    ///   - animated: true to animate the transition; otherwise, false
    /// - establishes which ViewController is being dismissed
    /// - makes sure the navigationController list of ViewControlled no longer contains the dismissed viewController
    /// - calls any closures for the dismissed viewController, if any
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let dismissedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        guard !navigationController.viewControllers.contains(dismissedViewController) else { return }
        performOnDismissAction(for: dismissedViewController)
    }
}
