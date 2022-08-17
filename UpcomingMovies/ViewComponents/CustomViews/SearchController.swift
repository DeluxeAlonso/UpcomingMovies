//
//  SearchController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

class SearchController: UISearchController {

    init(searchResultsController: UIViewController?,
         hidesNavigationBarDuringPresentation: Bool,
         searchBarStyle: UISearchBar.Style) {
        super.init(searchResultsController: searchResultsController)
        self.hidesNavigationBarDuringPresentation = hidesNavigationBarDuringPresentation
        self.searchBar.searchBarStyle = searchBarStyle
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
