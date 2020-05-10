//
//  SceneDelegate.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/16/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url,
            url.absoluteString == "extension://" {
            guard let tabBarController = window?.rootViewController as? UITabBarController else {
                return
            }
            tabBarController.selectedIndex = 1
        }
    }

}
