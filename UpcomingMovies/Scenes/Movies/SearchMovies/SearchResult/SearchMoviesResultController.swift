//
//  SearchMoviesResultController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

protocol SearchMoviesResultControllerDelegate: class {
    
    func searchMoviesResultController(_ searchMoviesResultController: SearchMoviesResultController, didSelectMovie movie: MovieDetailViewModel)
    
    func searchMoviesResultController(_ searchMoviesResultController: SearchMoviesResultController, didSelectRecentSearch searchText: String)
    
}

class SearchMoviesResultController: UIViewController, Keyboardable {
    
    private var viewModel: SearchMoviesResultViewModel
    private var dataSource: SearchMoviesResultDataSource!
    
    weak var delegate: SearchMoviesResultControllerDelegate?
    
    var searchMoviesResultView = SearchMoviesResultView()
    
    // MARK: - Initializers
    
    init(viewModel: SearchMoviesResultViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    // MARK: - Lifecycle
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func loadView() {
        super.loadView()
        view = searchMoviesResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers()
        setupUI()
        setupBindables()
    }
    
    // MARK: - Private
    
    private func setupObservers() {
        registerKeyboardWillShowNotification(using: { [weak self] keyboardFrame in
            self?.view.layoutIfNeeded()
            self?.searchMoviesResultView.tableViewBottomConstraint.constant = -keyboardFrame.size.height
            self?.view.layoutIfNeeded()
        })
        
        registerKeyboardWillHideNotification(using: { [weak self] in
            self?.view.layoutIfNeeded()
            self?.searchMoviesResultView.tableViewBottomConstraint.constant = 0
            self?.view.layoutIfNeeded()
        })
    }
    
    private func setupUI() {
        view.backgroundColor = ColorPalette.navigationBarBackgroundColor
        setupTableView()
    }
    
    private func setupTableView() {
        let tableView = searchMoviesResultView.tableView
        tableView.delegate = self
        tableView.registerNib(cellType: MovieTableViewCell.self)
        tableView.registerNib(cellType: RecentSearchTableViewCell.self)
    }
    
    private func reloadTableView() {
        dataSource = SearchMoviesResultDataSource(viewModel: viewModel)
        searchMoviesResultView.tableView.dataSource = dataSource
        searchMoviesResultView.tableView.reloadData()
    }
    
    private func configureView(with state: SearchMoviesResultViewModel.ViewState) {
        let tableView = searchMoviesResultView.tableView
        tableView.separatorStyle = .none
        switch state {
        case .empty:
            tableView.tableFooterView = CustomFooterView(message: Constants.emptyResultsTitle)
        case .populated, .initial:
            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .singleLine
        case .searching:
            tableView.tableFooterView = searchMoviesResultView.loadingFooterView
        case .error(let error):
            tableView.tableFooterView = CustomFooterView(message: error.description)
        }
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        viewModel.updateRecentSearches = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.reloadTableView()
        }
        
        viewModel.viewState.bindAndFire({ [weak self] state in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.configureView(with: state)
                strongSelf.reloadTableView()
            }
        })
    }
    
    // MARK: - Public
    
    func startSearch(withSearchText searchText: String) {
        viewModel.clearMovies()
        viewModel.searchMovies(withSearchText: searchText)
    }
    
    func resetSearch() {
        viewModel.resetViewState()
    }

}

// MARK: - UITableViewDelegate

extension SearchMoviesResultController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewState = viewModel.viewState.value
        switch viewState {
        case .initial:
            guard viewModel.recentSearchCells.count > 0 else { return }
            let searchText = viewModel.recentSearchCells[indexPath.row].searchText
            delegate?.searchMoviesResultController(self, didSelectRecentSearch: searchText)
        case .populated:
            let detailViewModel = viewModel.buildDetailViewModel(at: indexPath.row)
            delegate?.searchMoviesResultController(self, didSelectMovie: detailViewModel)
        case .empty, .error, .searching:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewState = viewModel.viewState.value
        switch viewState {
        case .initial:
            let headerView = SimpleHeaderView()
            headerView.headerTitle = Constants.recentSearchesHeaderTitle
            return headerView
        case .populated:
            let view = UIView()
            view.backgroundColor = .clear
            return view
        case .searching, .error, .empty:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let viewState = viewModel.viewState.value
        switch viewState {
        case .initial:
            return 50
        case .searching, .error, .empty, .populated:
            return 0
        }
    }
    
}

// MARK: - Constants

extension SearchMoviesResultController {
    
    struct Constants {
        static let recentSearchesHeaderTitle = NSLocalizedString("recentSearches", comment: "")
        static let emptyResultsTitle = NSLocalizedString("emptySearchResults", comment: "")
    }
    
}
