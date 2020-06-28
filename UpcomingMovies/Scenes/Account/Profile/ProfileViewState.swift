//
//  ProfileViewState.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

enum ProfileViewState {
    case initial
    
    var sections: [ProfileSection] {
        switch self {
        case .initial:
            return [.accountInfo, .collections, .groups, .signOut]
        }
    }
}
