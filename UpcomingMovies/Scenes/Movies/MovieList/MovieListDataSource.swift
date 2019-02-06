//
//  MovieListDataSource.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/6/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class MovieListDataSource: NSObject, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    private let viewModel: MovieListViewModel
    private let prefetchHandler: (() -> Void)?
    
    init(viewModel: MovieListViewModel, prefetchHandler: (() -> Void)? = nil) {
        self.viewModel = viewModel
        self.prefetchHandler = prefetchHandler
    }
    
    // MARK: - Data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as!
        MovieTableViewCell
        cell.viewModel = viewModel.movieCells[indexPath.row]
        return cell
    }
    
    // MARK: - Prefetching
    
    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.movieCells.count - 1
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let prefetchHandler = prefetchHandler else { return }
        if indexPaths.contains(where: isLoadingCell) {
            prefetchHandler()
        }
    }
    
}
