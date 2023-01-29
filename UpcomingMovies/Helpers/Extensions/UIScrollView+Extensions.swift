//
//  UIScrollView+Extensions.swift
//  UpcomingMovies
//
//  Created by Alonso on 12/10/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import UIKit

extension UIScrollView {

    func isScrolledToTop() -> Bool {
        contentOffset == .zero
    }

    func scrollToTop(animated: Bool) {
        setContentOffset(.zero, animated: animated)
    }

}
