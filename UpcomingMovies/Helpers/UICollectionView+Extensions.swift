//
//  UICollectionView+Extensions.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/5/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func scrollToTop(animated: Bool) {
        setContentOffset(.zero, animated: animated)
    }
    
}
