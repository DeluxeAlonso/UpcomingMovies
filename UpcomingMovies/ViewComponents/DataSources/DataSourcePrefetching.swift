//
//  DataSourcePrefetching.swift
//  UpcomingMovies
//
//  Created by Alonso on 5/26/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

protocol DataSourcePrefetching {
    
    var cellCount: Int { get set }
    var needsPrefetch: Bool { get set }
    var prefetchHandler: (() -> Void) { get set }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool
    
}

extension DataSourcePrefetching {
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= cellCount - 1
    }
    
    func prefetchIfNeeded(for indexPaths: [IndexPath]) {
        guard needsPrefetch else { return }
        if indexPaths.contains(where: isLoadingCell) {
            prefetchHandler()
        }
    }
    
}
