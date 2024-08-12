//
//  ProfileSelectableOptionCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/24/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

protocol ProfileSelectableOptionCellViewModelProtocol {

    var title: String? { get }

}

struct ProfileSelectableOptionCellViewModel: ProfileSelectableOptionCellViewModelProtocol {

    let title: String?

    init(_ profileCollectionOption: ProfileOptionProtocol) {
        self.title = profileCollectionOption.title
    }

}
