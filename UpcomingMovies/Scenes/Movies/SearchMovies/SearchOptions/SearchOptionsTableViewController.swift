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
                                          didSelectMovieGenreWithId genreId: Int, andGenreName genreName: String)
    
    func searchOptionsTableViewController(_ searchOptionsTableViewController: SearchOptionsTableViewController,
                                          didSelectRecentlyVisitedMovie id: Int,
                                          title: String)
    
}

class SearchOptionsTableViewController: UITableViewController {
    
    private var dataSource: SearchOptionsDataSource!
    
    weak var delegate: SearchOptionsTableViewControllerDelegate?
    
    var viewModel: SearchOptionsViewModel? {
        didSet {
            setupBindables()
        }
    }
    
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
        tableView.reloadData()
    }
    
    private func reloadSection(_ section: Int) {
        setupDataSource()
        tableView.performBatchUpdates({
            self.tableView.reloadSections(IndexSet(integer: section), with: .none)
        }, completion: nil)
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        viewModel?.needsContentReload = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.reloadTableView()
        }
        
        viewModel?.updateVisitedMovies.bind({ [weak self] section in
            guard let strongSelf = self,
                let section = section else {
                    return
            }
            strongSelf.reloadSection(section)
        })
        
        viewModel?.selectedDefaultSearchOption.bind({ [weak self] option in
            guard let strongSelf = self, let option = option else { return }
            switch option {
            case .popular:
                strongSelf.delegate?.searchOptionsTableViewController(strongSelf, didSelectPopularMovies: true)
            case .topRated:
                strongSelf.delegate?.searchOptionsTableViewController(strongSelf, didSelectTopRatedMovies: true)
            }
        })
        
        viewModel?.selectedMovieGenre.bind({ [weak self] (genreId, genreName) in
            guard let strongSelf = self,
                let genreId = genreId,
                let genreName = genreName else {
                    return
            }
            strongSelf.delegate?.searchOptionsTableViewController(strongSelf,
                                                                  didSelectMovieGenreWithId: genreId,
                                                                  andGenreName: genreName)
        })
        
        viewModel?.selectedRecentlyVisitedMovie = { [weak self] id, title in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.searchOptionsTableViewController(strongSelf, didSelectRecentlyVisitedMovie: id, title: title)
        }
        
        viewModel?.load()
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
