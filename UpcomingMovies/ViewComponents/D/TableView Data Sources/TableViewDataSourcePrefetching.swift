//
//  TableViewDataSourcePrefetching.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/9/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class TableViewDataSourcePrefetching: NSObject, UITableViewDataSourcePrefetching {
    
    private var cellCount: Int
    private let prefetchHandler: (() -> Void)
    
    init(cellCount: Int, prefetchHandler: @escaping (() -> Void)) {
        self.cellCount = cellCount
        self.prefetchHandler = prefetchHandler
    }
    
    func updateCellCount(_ cellCount: Int) {
        self.cellCount = cellCount
    }
    
    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= cellCount - 1
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard tableView.visibleCells.count > 1 else { return }
        if indexPaths.contains(where: isLoadingCell) {
            prefetchHandler()
        }
    }

}
