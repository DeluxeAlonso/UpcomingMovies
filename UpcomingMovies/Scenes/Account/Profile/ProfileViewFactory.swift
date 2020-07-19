//
//  ProfileViewFactory.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/18/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

final class ProfileViewFactory: ProfileViewFactoryProtocol {
    
    var sections: [ProfileSection] {
        return [
            .accountInfo,
            .collections,
            .groups,
            .signOut
        ]
    }
    
    var collectionOptions: [ProfileCollectionOption] {
        return [.favorites, .watchlist]
    }
    
    var groupOptions: [ProfileGroupOption] {
        return [.customLists]
    }
    
    var configurationOptions: [ProfileConfigurationOption] {
        return []
    }
    
}
