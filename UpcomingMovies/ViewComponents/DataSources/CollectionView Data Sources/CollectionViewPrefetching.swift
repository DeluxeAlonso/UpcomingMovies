//
//  CollectionViewDataSourcePrefetching.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/9/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class CollectionViewPrefetching: NSObject, UICollectionViewDataSourcePrefetching {
    
    private let cellCount: Int
    private let prefetchHandler: (() -> Void)
    
    init(cellCount: Int, prefetchHandler: @escaping (() -> Void)) {
        self.cellCount = cellCount
        self.prefetchHandler = prefetchHandler
    }

    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= cellCount - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            prefetchHandler()
        }
    }
    
}
