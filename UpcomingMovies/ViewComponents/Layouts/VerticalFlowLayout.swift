//
//  VerticalFlowLayout.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/9/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

final class VerticalFlowLayout: UICollectionViewFlowLayout {

    private var preferredWidth: Double
    private var preferredHeight: Double
    private let margin: CGFloat
    private let minColumns: Int

    // MARK: - Initializers
    
    init(preferredWidth: Double,
         preferredHeight: Double,
         margin: CGFloat = 16.0,
         minColumns: Int = 0) {
        self.preferredWidth = preferredWidth
        self.preferredHeight = preferredHeight
        self.margin = margin
        self.minColumns = minColumns
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    // MARK: - Lifecycle

    override func prepare() {
        super.prepare()
        itemSize = CGSize(width: preferredWidth, height: preferredHeight)
        sectionInset = UIEdgeInsets(top: margin, left: margin,
                                    bottom: margin, right: margin)
    }

    // MARK: - Public

    func updatePreferredWidth(_ width: Double) {
        self.preferredWidth = width
    }

    func updatePreferredHeight(_ height: Double) {
        self.preferredHeight = height
    }

}
