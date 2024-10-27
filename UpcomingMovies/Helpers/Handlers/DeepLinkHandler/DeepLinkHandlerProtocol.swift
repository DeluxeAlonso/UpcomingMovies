//
//  DeepLinkHandlerProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 21/10/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import UIKit

protocol DeepLinkHandlerProtocol {

    func register(rootCoordinators: [RootCoordinator])
    func handleDeepLinkUrl(_ url: URL, in window: UIWindow?)

}
