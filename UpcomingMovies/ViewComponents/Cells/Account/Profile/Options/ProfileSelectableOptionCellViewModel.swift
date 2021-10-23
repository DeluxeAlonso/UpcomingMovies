//
//  ProfileSelectableOptionCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/24/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

protocol ProfileSelectableOptionCellViewModelProtocol {

    var title: String? { get }

}

final class ProfileSelectableOptionCellViewModel: ProfileSelectableOptionCellViewModelProtocol {

    let title: String?

    init(_ profileCollectionOption: ProfileOptionProtocol) {
        self.title = profileCollectionOption.title
    }

}
