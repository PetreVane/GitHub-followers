//
//  SceneDelegate.swift
//  Github-Followers
//
//  Created by Petre Vane on 30/12/2019.
//  Copyright © 2019 Petre Vane. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appDelegateRouter: AppDelegateRouter?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // init window with the frameSize of the windowScene bounds
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        
        //assign windowScene to window
        window?.windowScene = windowScene
        
        // init AppDelegateRouter
        guard let window = window else { print("Window failed"); return }
        appDelegateRouter = AppDelegateRouter(window: window)
    }

}

