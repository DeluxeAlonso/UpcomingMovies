//
//  VerticalFlowLayout.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/9/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

final class VerticalFlowLayout: UICollectionViewFlowLayout {

    private var preferredWidth: CGFloat
    private var preferredHeight: CGFloat
    private let margin: CGFloat
    private let minColumns: Int

    // MARK: - Initializers

    init(preferredWidth: CGFloat,
         preferredHeight: CGFloat,
         margin: CGFloat = 16.0,
         minColumns: Int = .zero) {
        self.preferredWidth = preferredWidth
        self.preferredHeight = preferredHeight
        self.margin = margin
        self.minColumns = minColumns
        super.init()

        sectionInsetReference = .fromSafeArea
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

            if maximumItemWidth < preferredWidth {
                finalWidth = maximumItemWidth
                finalHeight = finalWidth * (preferredHeight / preferredWidth)
            }
        }

        itemSize = CGSize(width: finalWidth, height: finalHeight)
        sectionInset = UIEdgeInsets(top: margin, left: margin,
                                    bottom: margin, right: margin)
    }

    // MARK: - Internal

    func updatePreferredWidth(_ width: CGFloat) {
        self.preferredWidth = width
    }

    func updatePreferredHeight(_ height: CGFloat) {
        self.preferredHeight = height
    }

}
