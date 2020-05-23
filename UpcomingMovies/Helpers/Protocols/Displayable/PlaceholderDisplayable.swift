//
//  PlaceholderDisplayable.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/7/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

protocol PlaceholderDisplayable: Retryable, Emptiable {}

extension PlaceholderDisplayable where Self: UIViewController {
    
    func hideDisplayedPlaceholderView() {
        hideEmptyView()
        hideRetryView()
    }
    
}
