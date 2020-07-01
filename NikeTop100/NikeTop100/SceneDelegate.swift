//
//  SceneDelegate.swift
//  NikeTop100
//
//  Created by Augustus Wilson on 6/27/20.
//  Copyright © 2020 Augustus Wilson. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private var navigationCoordinator : NavigationCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            self.window = window
            navigationCoordinator = AlbumListNavigationCoordinator()
            window.rootViewController = navigationCoordinator?.getInitialViewController();
            window.makeKeyAndVisible()
        }
    }

}

