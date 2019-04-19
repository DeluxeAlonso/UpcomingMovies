//
//  ProfileSelectableOptionCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/24/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class ProfileSelectableOptionCellViewModel {
    
    let title: String?
    
    init(_ profileCollectionOption: ProfileOption) {
        self.title = profileCollectionOption.title
    }
    
}
