//
//  FullscreenDisplayable.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/7/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

protocol FullscreenDisplayable: FullscreenRetryable, FullscreenEmptiable {}

extension FullscreenDisplayable where Self: UIViewController {
    
    func hideFullscreenDisplayedView() {
        hideEmptyView()
        hideErrorView()
    }
    
}
