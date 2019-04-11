//
//  Displayable.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/7/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

protocol Displayable: Retryable, Emptiable {}

extension Displayable where Self: UIViewController {
    
    func hideFullscreenDisplayedView() {
        hideEmptyView()
        hideErrorView()
    }
    
}
