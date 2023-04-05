//
//  SceneDelegate.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 4/4/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
     
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navVC = UINavigationController()
        let coordinator = Router()
        coordinator.navController = navVC
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navVC
        window.makeKeyAndVisible()
        self.window = window
        
        coordinator.start()
    }
}
