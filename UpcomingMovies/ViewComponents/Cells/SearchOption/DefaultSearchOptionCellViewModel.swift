//
//  DefaultSearchOptionCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/15/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class DefaultSearchOptionCellViewModel {
    
    var title: String?
    var subtitle: String?
    
    init(defaultSearchOption: DefaultSearchOption) {
        title = defaultSearchOption.title
        subtitle = defaultSearchOption.subtitle
    }
    
}
