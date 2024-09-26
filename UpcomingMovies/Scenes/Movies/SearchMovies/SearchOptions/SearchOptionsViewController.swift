//
//  SearchOptionsViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/15/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

final class SearchOptionsViewController: UITableViewController, Storyboarded {

    static var storyboardName = "SearchMovies"

    private var dataSource: SearchOptionsDataSource?

    var viewModel: SearchOptionsViewModelProtocol?
    weak var delegate: SearchOptionsViewControllerDelegate?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindables()

        viewModel?.loadGenres()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // TODO: - Temporal fix to didUpdateMovieVisit not working as expected
        viewModel?.loadVisitedMovies()
    }

    // MARK: - Private

    private func setupUI() {
        setupTableView()
    }

    private func setupTableView() {
        tableView.register(cellType: DefaultSearchOptionTableViewCell.self)
        tableView.registerNib(cellType: RecentlyVisitedMoviesTableViewCell.self)
        tableView.registerNib(cellType: GenreSearchOptionTableViewCell.self)
    }

    private func setupDataSource() {
        dataSource = viewModel.flatMap { SearchOptionsDataSource(viewModel: $0) }
        tableView.dataSource = dataSource
    }

    private func reloadTableView() {
        setupDataSource()
        tableView.reloadData()
    }

    private func reloadSection(_ section: Int) {
        setupDataSource()
        tableView.performBatchUpdates({
            self.tableView.reloadSections(IndexSet(integer: section), with: .none)
        }, completion: nil)
    }

    // MARK: - Reactive Behavior

    private func setupBindables() {
        viewModel?.needsContentReload.bind({ [weak self] in
            guard let self = self else { return }
            self.reloadTableView()
        }, on: .main)

        viewModel?.updateVisitedMovies.bind({ [weak self] section in
            guard let self = self else { return }
            self.reloadSection(section)
        }, on: .main)

        viewModel?.selectedDefaultSearchOption.bind({ [weak self] option in
            guard let self = self else { return }
            self.delegate?.searchOptionsViewController(self, didSelectDefaultSearchOption: option)
        }, on: .main)

        viewModel?.selectedMovieGenre.bind({ [weak self] movieGenre in
            guard let self = self else { return }
            self.delegate?.searchOptionsViewController(self, didSelectMovieGenreWithId: movieGenre.0, andGenreName: movieGenre.1)
        }, on: .main)

        viewModel?.selectedRecentlyVisitedMovie.bind({ [weak self] movieVisit in
            guard let self = self else { return }
            self.delegate?.searchOptionsViewController(self, didSelectRecentlyVisitedMovie: movieVisit.0, title: movieVisit.1)
        }, on: .main)
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewModel = viewModel else { return }
        switch viewModel.section(at: indexPath.section) {
        case .recentlyVisited:
            break
        case .defaultSearches:
            viewModel.getDefaultSearchSelection(by: indexPath.row)
        case .genres:
            viewModel.getMovieGenreSelection(by: indexPath.row)
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let viewModel = viewModel else { return .zero }
        switch viewModel.section(at: indexPath.section) {
        case .recentlyVisited:
            return Constants.recentlyVisitedRowHeight
        case .defaultSearches:
            return UITableView.automaticDimension
        case .genres:
            return Constants.genresRowHeight
        }
    }

}

extension SearchOptionsViewController {
    struct Constants {
        static let recentlyVisitedRowHeight: CGFloat = 140.0
        static let genresRowHeight: CGFloat = 50.0
    }
}
