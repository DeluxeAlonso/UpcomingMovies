//
//  SearchOptionsDataSource.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/8/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class SearchOptionsDataSource: NSObject, UITableViewDataSource {
    
    private var viewModel: SearchOptionsViewModelProtocol?
    
    init(viewModel: SearchOptionsViewModelProtocol?) {
        self.viewModel = viewModel
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.viewState.value.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let viewModel = viewModel else { return nil }
        let sections = viewModel.viewState.value.sections
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        switch viewModel.section(at: section) {
        case .recentlyVisited:
            return 1
        case .defaultSearches:
            return viewModel.defaultSearchOptionsCells.count
        case .genres:
            return viewModel.genreCells.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return  UITableViewCell() }
        switch viewModel.section(at: indexPath.section) {
        case .recentlyVisited:
            return recentlyVisitedDataSource(tableView, at: indexPath)
        case .defaultSearches:
            return defaultSearchOptionDataSource(tableView, at: indexPath)
        case .genres:
            return genreSearchOptionDataSource(tableView, at: indexPath)
        }
    }
    
    private func recentlyVisitedDataSource(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { fatalError() }
        let cell = tableView.dequeueReusableCell(with: RecentlyVisitedMoviesTableViewCell.self, for: indexPath)
        cell.selectionStyle = .none
        cell.delegate = self
        cell.viewModel = viewModel.buildRecentlyVisitedMoviesCell()
        return cell
    }
    
    private func defaultSearchOptionDataSource(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: DefaultSearchOptionTableViewCell.self, for: indexPath)
        cell.viewModel = viewModel?.defaultSearchOptionsCells[indexPath.row]
        return cell
    }
    
    private func genreSearchOptionDataSource(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: GenreSearchOptionTableViewCell.self, for: indexPath)
        cell.viewModel = viewModel?.genreCells[indexPath.row]
        return cell
    }

}

// MARK: - RecentlyVisitedMoviesTableViewCellDelegate

extension SearchOptionsDataSource: RecentlyVisitedMoviesTableViewCellDelegate {
    
    func recentlyVisitedMoviesTableViewCell(_ recentlyVisitedMoviesTableViewCell: RecentlyVisitedMoviesTableViewCell,
                                            didSelectMovieAt indexPath: IndexPath) {
        viewModel?.getRecentlyVisitedMovieSelection(by: indexPath.row)
    }
    
}
