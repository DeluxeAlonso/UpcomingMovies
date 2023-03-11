//
//  SearchMoviesResultDataSource.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/8/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

final class SearchMoviesResultDataSource: NSObject, UITableViewDataSource {

    private let viewModel: SearchMoviesResultViewModelProtocol

    init(viewModel: SearchMoviesResultViewModelProtocol) {
        self.viewModel = viewModel
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = viewModel.viewState.value.sections else { return 0 }
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = viewModel.viewState.value.sections?[section] else { return 0 }
        switch section {
        case .recentSearches:
            return viewModel.recentSearchCells.count
        case .searchedMovies:
            return viewModel.movieCells.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = viewModel.viewState.value.sections?[indexPath.section] else { return UITableViewCell() }
        switch section {
        case .recentSearches:
            return recentSearchesDataSource(tableView, indexPath: indexPath)
        case .searchedMovies:
            return searchedMoviesDataSource(tableView, indexPath: indexPath)
        }
    }

    private func recentSearchesDataSource(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: RecentSearchCell.self, for: indexPath)
        guard indexPath.row < viewModel.recentSearchCells.count else { return UITableViewCell() }
        cell.viewModel = viewModel.recentSearchCells[indexPath.row]
        return cell
    }

    private func searchedMoviesDataSource(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: MovieListCell.self, for: indexPath)
        cell.viewModel = viewModel.movieCells[indexPath.row]
        return cell
    }

}
