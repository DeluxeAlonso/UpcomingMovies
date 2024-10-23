//
//  DeepLinkHandler.swift
//  UpcomingMovies
//
//  Created by Alonso on 20/10/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import Foundation

final class DeepLinkHandler: DeepLinkHandlerProtocol {

    func handleDeepLinkUrl(_ url: URL) {
        guard let urlHost = url.host else { return }

            guard let host = DeepLinkDestination(rawValue: urlHost) else { return }
            switch host {
            case .upcomingMovies:
                changeTabBarToSelectedIndex(RootCoordinatorIdentifier.upcomingMovies, from: window)

            case .searchMovies:
                changeTabBarToSelectedIndex(RootCoordinatorIdentifier.searchMovies, from: window)
            case .detail:
                // TODO: - Implement DeepLink Handler
                break
            }
    }

}
