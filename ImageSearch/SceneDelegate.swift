//
//  SceneDelegate.swift
//  Candyspace
//
//  Created by gaetano cerniglia on 15/03/2020.
//  Copyright © 2020 Gaetano Cerniglia. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var appCoordinator: Coordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Setup the initial Window
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        // Create and Start the coordinator to begin the navigation
        appCoordinator = Coordinator(window: window)
    }


}

