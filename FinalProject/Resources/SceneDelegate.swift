//
//  SceneDelegate.swift
//  FinalProject
//
//  Created by Бекжан on 12.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        
        let viewController = MainViewController()
        window?.rootViewController = UINavigationController(rootViewController: viewController)
//        window?.rootViewController = MainViewController()
    }
}


