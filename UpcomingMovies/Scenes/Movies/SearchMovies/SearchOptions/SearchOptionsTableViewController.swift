//
//  SearchOptionsTableViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/15/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

protocol SearchOptionsTableViewControllerDelegate: class {
    
    func searchOptionsTableViewController(_ searchOptionsTableViewController: SearchOptionsTableViewController, didSelectPopularMovies selected: Bool)
    
    func searchOptionsTableViewController(_ searchOptionsTableViewController: SearchOptionsTableViewController,
                                          didSelectTopRatedMovies selected: Bool)
    
    func searchOptionsTableViewController(_ searchOptionsTableViewController: SearchOptionsTableViewController, didSelectMovieGenre genreId: Int)
    
}

class SearchOptionsTableViewController: UITableViewController {
    
    var viewModel: SearchOptionsViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    weak var delegate: SearchOptionsTableViewControllerDelegate?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(RecentlyVisitedMoviesTableViewCell.self,
                           forCellReuseIdentifier: RecentlyVisitedMoviesTableViewCell.identifier)
        tableView.register(UINib(nibName: RecentlyVisitedMoviesTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: RecentlyVisitedMoviesTableViewCell.identifier)
        
        tableView.register(DefaultSearchOptionTableViewCell.self,
                           forCellReuseIdentifier: DefaultSearchOptionTableViewCell.identifier)
        
        tableView.register(GenreSearchOptionTableViewCell.self,
                           forCellReuseIdentifier: GenreSearchOptionTableViewCell.identifier)
        tableView.register(UINib(nibName: GenreSearchOptionTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: GenreSearchOptionTableViewCell.identifier)
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        viewModel?.prepareUpdate = { [weak self] beginUpdate in
            guard let strongSelf = self else { return }
            beginUpdate ? strongSelf.tableView.beginUpdates() : strongSelf.tableView.endUpdates()
        }
        
        viewModel?.updateVisitedMovies = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.tableView.reloadSections(IndexSet(integer: 0), with: .none)
        }
        
        viewModel?.selectedDefaultSearchOption = { [weak self] option in
            guard let strongSelf = self else { return }
            switch option {
            case .popular:
                strongSelf.delegate?.searchOptionsTableViewController(strongSelf, didSelectPopularMovies: true)
            case .topRated:
                strongSelf.delegate?.searchOptionsTableViewController(strongSelf, didSelectTopRatedMovies: true)
            }
        }
        
        viewModel?.selectedMovieGenre = { [weak self] genredId in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.searchOptionsTableViewController(strongSelf, didSelectMovieGenre: genredId)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.viewState.value.sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let viewModel = viewModel else { return nil }
        let sections = viewModel.viewState.value.sections
        return sections[section].title
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentlyVisitedMoviesTableViewCell.identifier,
                                                 for: indexPath) as! RecentlyVisitedMoviesTableViewCell
        cell.viewModel = viewModel.prepareRecentlyVisitedMoviesCell()
        return cell
    }
    
    private func defaultSearchOptionDataSource(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DefaultSearchOptionTableViewCell.identifier,
                                                 for: indexPath) as! DefaultSearchOptionTableViewCell
        cell.viewModel = viewModel?.defaultSearchOptionsCells[indexPath.row]
        return cell
    }
    
    private func genreSearchOptionDataSource(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GenreSearchOptionTableViewCell.identifier,
                                                 for: indexPath) as! GenreSearchOptionTableViewCell
        cell.viewModel = viewModel?.genreCells[indexPath.row]
        return cell
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
