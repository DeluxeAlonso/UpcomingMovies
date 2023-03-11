//
//  SearchMoviesResultController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

protocol SearchMoviesResultControllerDelegate: UIViewController {

    func searchMoviesResultController(_ searchMoviesResultController: SearchMoviesResultController, didSelectRecentSearch searchText: String)

}

class SearchMoviesResultController: UIViewController, Keyboardable {

    private var viewModel: SearchMoviesResultViewModelProtocol
    private var dataSource: SearchMoviesResultDataSource!

    weak var delegate: SearchMoviesResultControllerDelegate?
    weak var coordinator: SearchMoviesCoordinator?

    var searchMoviesResultView = SearchMoviesResultView()

    // MARK: - Initializers

    init(viewModel: SearchMoviesResultViewModelProtocol) {
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

        viewModel.loadRecentSearches()
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
        view.backgroundColor = ColorPalette.defaultBackgroundColor
        setupTableView()
    }

    private func setupTableView() {
        let tableView = searchMoviesResultView.tableView
        tableView.delegate = self
        if #available(iOS 15.0, *) { tableView.sectionHeaderTopPadding = .zero }
        tableView.registerNib(cellType: MovieListCell.self)
        tableView.registerNib(cellType: RecentSearchCell.self)
    }

    private func reloadTableView() {
        dataSource = SearchMoviesResultDataSource(viewModel: viewModel)
        searchMoviesResultView.tableView.dataSource = dataSource
        searchMoviesResultView.tableView.reloadData()
    }

    private func configureView(with state: SearchMoviesResultViewState) {
        let tableView = searchMoviesResultView.tableView
        tableView.separatorStyle = .none
        switch state {
        case .empty:
            tableView.tableFooterView = FooterView(message: LocalizedStrings.emptySearchResults())
        case .populated, .recentSearches:
            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .singleLine
        case .searching:
            tableView.tableFooterView = searchMoviesResultView.loadingFooterView
        case .error(let error):
            tableView.tableFooterView = FooterView(message: error.localizedDescription)
        }
    }

    // MARK: - Reactive Behavior

    private func setupBindables() {
        viewModel.viewState.bindAndFire({ [weak self] state in
            guard let self else { return }
            self.configureView(with: state)
            self.reloadTableView()
        }, on: .main)
        viewModel.needsRefresh.bind({ [weak self] in
            guard let self else { return }
            self.reloadTableView()
        }, on: .main)
    }

    // MARK: - Internal

    func startSearch(withSearchText searchText: String) {
        viewModel.clearMovies()
        viewModel.searchMovies(withSearchText: searchText)
    }

    func resetSearch() {
        viewModel.clearMovies()
    }

}

// MARK: - UITableViewDelegate

extension SearchMoviesResultController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewState = viewModel.viewState.value
        switch viewState {
        case .recentSearches:
            guard viewModel.recentSearchCells.count > 0 else { return }
            let searchText = viewModel.recentSearchCells[indexPath.row].searchText
            delegate?.searchMoviesResultController(self, didSelectRecentSearch: searchText)
        case .populated:
            coordinator?.showMovieDetail(for: viewModel.searchedMovie(at: indexPath.row))
        case .empty, .error, .searching:
            return
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewState = viewModel.viewState.value
        switch viewState {
        case .recentSearches:
            let headerView = HeaderView()
            headerView.headerTitle = LocalizedStrings.recentSearches()
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
        case .recentSearches:
            return 50
        case .searching, .error, .empty, .populated:
            return 0
        }
    }

}
