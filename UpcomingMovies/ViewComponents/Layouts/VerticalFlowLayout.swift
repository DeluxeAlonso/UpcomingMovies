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
         minColumns: Int = .zero) {
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
        // Evaluates if we are gonna finally use the preferred width or not
        var finalWidth = preferredWidth
        var finalHeight = preferredHeight
        if minColumns != .zero, let collectionView = collectionView {
            let totalHorzontalSafeAreaInset = collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right

            let horizontalSpacePerItem = margin * 2 + totalHorzontalSafeAreaInset + minimumInteritemSpacing
            let totalHorizontalSpace = horizontalSpacePerItem * CGFloat(minColumns - 1)
            let maximumItemWidth = ((collectionView.bounds.size.width - totalHorizontalSpace) / CGFloat(minColumns)).rounded(.down)

            if Double(maximumItemWidth) < preferredWidth {
                finalWidth = Double(maximumItemWidth)
                finalHeight = finalWidth * (preferredHeight / preferredWidth)
            }
        }

        itemSize = CGSize(width: finalWidth, height: finalHeight)
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
