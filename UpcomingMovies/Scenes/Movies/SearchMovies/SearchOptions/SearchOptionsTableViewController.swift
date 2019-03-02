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
    
    func searchOptionsTableViewController(_ searchOptionsTableViewController: SearchOptionsTableViewController,
                                          didSelectMovieGenre genreId: Int, and genreName: String)
    
}

class SearchOptionsTableViewController: UITableViewController {
    
    var viewModel: SearchOptionsViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    private var dataSource: SearchOptionsDataSource!
    
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
        tableView.reloadSections(IndexSet(integer: 0), with: .none)
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        setupDataSource()
        
        viewModel?.prepareUpdate = { [weak self] beginUpdate in
            guard let strongSelf = self else { return }
            beginUpdate ? strongSelf.tableView.beginUpdates() : strongSelf.tableView.endUpdates()
        }
        
        viewModel?.updateVisitedMovies = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.reloadTableView()
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
        
        viewModel?.selectedMovieGenre = { [weak self] genredId, genreName in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.searchOptionsTableViewController(strongSelf,
                                                                  didSelectMovieGenre: genredId,
                                                                  and: genreName)
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
