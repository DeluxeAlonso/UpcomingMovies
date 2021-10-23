//
//  RecentSearchCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation

protocol RecentSearchCellViewModelProtocol {

    var searchText: String { get }

}

final class RecentSearchCellViewModel: RecentSearchCellViewModelProtocol {

    let searchText: String

    init(searchText: String) {
        self.searchText = searchText
    }

}
