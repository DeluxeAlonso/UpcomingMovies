//
//  SquareFlowLayout.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/9/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class SquareFlowLayout: UICollectionViewFlowLayout {
    
    init(height: Double, margin: CGFloat) {
        super.init()
        let posterHeight: Double = height
        let posterWidth: Double = posterHeight / Movie.posterAspectRatio
        itemSize = CGSize(width: posterWidth, height: posterHeight)
        sectionInset = UIEdgeInsets(top: margin, left: margin,
                                           bottom: margin, right: margin)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
