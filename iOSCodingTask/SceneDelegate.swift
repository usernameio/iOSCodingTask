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
        guard let windowSecen = (scene as? UIWindowScene) else { return }
        
        let navVC = UINavigationController()
        let router = Router()
        router.navController = navVC
        
        let window = UIWindow(windowScene: windowSecen)
        window.rootViewController = navVC
        window.makeKeyAndVisible()
        self.window = window
        
        router.push(viewModel: BaseViewModel(router: router))
    }
}
