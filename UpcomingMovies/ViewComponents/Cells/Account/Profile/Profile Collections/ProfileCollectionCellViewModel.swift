//
//  ProfileCollectionCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/24/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class ProfileCollectionCellViewModel {
    
    let title: String?
    
    init(_ profileCollectionOption: ProfileCollectionOption) {
        self.title = profileCollectionOption.title
    }
    
}
