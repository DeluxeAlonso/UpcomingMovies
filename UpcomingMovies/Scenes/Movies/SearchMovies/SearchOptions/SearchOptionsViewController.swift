//
//  SearchOptionsViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/15/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class SearchOptionsViewController: UITableViewController, Storyboarded {

    static var storyboardName = "SearchMovies"

    private var dataSource: SearchOptionsDataSource!

    var viewModel: SearchOptionsViewModelProtocol?
    weak var delegate: SearchOptionsViewControllerDelegate?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindables()

        viewModel?.loadGenres()
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
        dataSource = SearchOptionsDataSource(viewModel: viewModel)
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
        }, onMainThread: true)

        viewModel?.updateVisitedMovies.bind({ [weak self] section in
            guard let self = self, let section = section else { return }
            self.reloadSection(section)
        }, onMainThread: true)

        viewModel?.selectedDefaultSearchOption.bind({ [weak self] option in
            guard let self = self, let option = option else { return }
            self.delegate?.searchOptionsViewController(self, didSelectDefaultSearchOption: option)
        })

        viewModel?.selectedMovieGenre.bind({ [weak self] (genreId, genreName) in
            guard let self = self,
                let genreId = genreId,
                let genreName = genreName else {
                    return
            }
            self.delegate?.searchOptionsViewController(self,
                                                                  didSelectMovieGenreWithId: genreId,
                                                                  andGenreName: genreName)
        })

        viewModel?.selectedRecentlyVisitedMovie = { [weak self] id, title in
            guard let self = self else { return }
            self.delegate?.searchOptionsViewController(self, didSelectRecentlyVisitedMovie: id, title: title)
        }
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
        guard let viewModel = viewModel else { return 0.0 }
        switch viewModel.section(at: indexPath.section) {
        case .recentlyVisited:
            return 140.0
        case .defaultSearches:
            return 65.0
        case .genres:
           return 50.0
        }
    }

}
