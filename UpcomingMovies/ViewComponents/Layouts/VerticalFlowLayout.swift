//
//  VerticalFlowLayout.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/9/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class VerticalFlowLayout: UICollectionViewFlowLayout {
    
    init(width: Double, height: Double, margin: CGFloat = 16.0) {
        super.init()
        itemSize = CGSize(width: width, height: height)
        sectionInset = UIEdgeInsets(top: margin, left: margin,
                                    bottom: margin, right: margin)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
