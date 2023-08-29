//
//  SceneDelegate.swift
//  Medi-Buddy
//
//  Created by Jinah Park on 2023/08/13.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let tabBarController = CustomTabBarViewController()
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}
