//
//  VerticalCarouselLayout.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

// The heights are declared as constants outside of the class so they can be easily referenced elsewhere
struct VerticalCarouselLayoutConstants {
    struct Cell {
        // The height of the non-featured cell
        static let standardHeight: CGFloat = 100
        // The height of the first visible cell
        static let featuredHeight: CGFloat = 280
    }
}

// MARK: Properties and Variables

class VerticalCarouselLayout: UICollectionViewLayout {
    // The amount the user needs to scroll before the featured cell changes
    let dragOffset: CGFloat = 180.0
    
    var cache: [UICollectionViewLayoutAttributes] = []
    
    // Returns the item index of the currently featured cell
    var featuredItemIndex: Int {
        // Use max to make sure the featureItemIndex is never < 0
        return max(0, Int(collectionView!.contentOffset.y / dragOffset))
    }
    
    // Returns a value between 0 and 1 that represents how close the next cell is to becoming the featured cell
    var nextItemPercentageOffset: CGFloat {
        return (collectionView!.contentOffset.y / dragOffset) - CGFloat(featuredItemIndex)
    }
    
    // Returns the width of the collection view
    var width: CGFloat {
        return collectionView!.bounds.width
    }
    
    // Returns the height of the collection view
    var height: CGFloat {
        return collectionView!.bounds.height
    }
    
    // Returns the number of items in the collection view
    var numberOfItems: Int {
        return collectionView!.numberOfItems(inSection: 0)
    }
}

// MARK: UICollectionViewLayout

extension VerticalCarouselLayout {
    // Return the size of all the content in the collection view
    override var collectionViewContentSize: CGSize {
        let contentHeight = (CGFloat(numberOfItems) * dragOffset) + (height - dragOffset)
        return CGSize(width: width, height: contentHeight)
    }
    
    override func prepare() {
        cache.removeAll(keepingCapacity: false)
        
        let standardHeight = VerticalCarouselLayoutConstants.Cell.standardHeight
        let featuredHeight = VerticalCarouselLayoutConstants.Cell.featuredHeight
        
        var frame = CGRect.zero
        var yPos: CGFloat = 0
        
        for item in 0..<numberOfItems {
            let indexPath = IndexPath(item: item, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            // Important because each cell has to slide over the top of the previous one
            attributes.zIndex = item
            // Initially set the height of the cell to the standard height
            var height = standardHeight
            if indexPath.item == featuredItemIndex {
                // The featured cell
                let yOffset = standardHeight * nextItemPercentageOffset
                yPos = collectionView!.contentOffset.y - yOffset
                height = featuredHeight
            } else if indexPath.item == (featuredItemIndex + 1) && indexPath.item != numberOfItems {
                // The cell directly below the featured cell, which grows as the user scrolls
                let maxY = yPos + standardHeight
                height = standardHeight + max((featuredHeight - standardHeight) * nextItemPercentageOffset, 0)
                yPos = maxY - height
            }
            frame = CGRect(x: 0, y: yPos, width: width, height: height)
            attributes.frame = frame
            cache.append(attributes)
            yPos = frame.maxY
        }
    }
    
    // Return all attributes in the cache whose frame intersects with the rect passed to the method
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes: [UICollectionViewLayoutAttributes] = []
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    // Return the content offset of the nearest cell which achieves the nice snapping effect, similar to a paged UIScrollView
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let itemIndex = round(proposedContentOffset.y / dragOffset)
        let yOffset = itemIndex * dragOffset
        return CGPoint(x: 0, y: yOffset)
    }
    
    // Return true so that the layout is continuously invalidated as the user scrolls
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
