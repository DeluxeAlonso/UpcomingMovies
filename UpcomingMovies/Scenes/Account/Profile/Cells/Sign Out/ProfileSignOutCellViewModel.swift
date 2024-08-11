//
//  ProfileSignOutCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/08/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import Foundation

protocol ProfileSignOutCellViewModelProtocol {

    var title: String { get }

}

struct ProfileSignOutCellViewModel: ProfileSignOutCellViewModelProtocol {

    var title: String {
        LocalizedStrings.signOut()
    }

}
