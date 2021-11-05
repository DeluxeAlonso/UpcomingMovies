//
//  DataSourcePrefetching.swift
//  UpcomingMovies
//
//  Created by Alonso on 5/26/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

protocol DataSourcePrefetching {

    var cellCount: Int { get }
    var needsPrefetch: Bool { get }
    var prefetchHandler: (() -> Void) { get }

    func isLoadingCell(for indexPath: IndexPath) -> Bool
    func prefetchIfNeeded(for indexPaths: [IndexPath])

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
