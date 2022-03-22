//
//  CustomListsViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/19/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

class CustomListsViewController: UIViewController, Storyboarded, PlaceholderDisplayable, LoadingDisplayable {

    @IBOutlet private weak var tableView: UITableView!

    static var storyboardName = "CustomLists"

    private var dataSource: SimpleTableViewDataSource<CustomListCellViewModelProtocol>!

    var viewModel: CustomListsViewModelProtocol?
    weak var coordinator: CustomListsCoordinatorProtocol?

    // MARK: - LoadingDisplayable

    var loaderView: LoadingView = RadarView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindables()

        viewModel?.getCustomLists()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let textAttributes: [NSAttributedString.Key: UIColor]
        textAttributes = [NSAttributedString.Key.foregroundColor: ColorPalette.Label.defaultColor]

        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }

    // MARK: - Private

    private func setupUI() {
        title = LocalizedStrings.customListGroupOption()

        setupNavigationBar()
        setupTableView()
    }

    private func setupNavigationBar() {
        let backBarButtonItem = UIBarButtonItem(title: "",
                                                style: .done,
                                                target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
    }

    private func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100.0
        tableView.delegate = self
        tableView.registerNib(cellType: CustomListTableViewCell.self)
    }

    private func reloadTableView() {
        guard let viewModel = viewModel else { return }
        dataSource = SimpleTableViewDataSource.make(for: viewModel.listCells)
        tableView.dataSource = dataSource
        tableView.reloadData()
    }

    /**
     * Configures the tableview given its current state.
     */
    private func configureView(withState state: SimpleViewState<List>) {
        switch state {
        case .populated, .paging, .initial:
            hideDisplayedPlaceholderView()
            tableView.tableFooterView = UIView()
        case .empty:
            presentEmptyView(with: "No created lists to show")
        case .error(let error):
            presentRetryView(with: error.localizedDescription,
                             retryHandler: { [weak self] in
                                self?.viewModel?.refreshCustomLists()
            })
        }
    }

    // MARK: - Reactive Behavior

    private func setupBindables() {
        viewModel?.viewState.bindAndFire({ [weak self] state in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.configureView(withState: state)
                self.reloadTableView()
            }
        })
        viewModel?.startLoading.bind({ [weak self] start in
            start ? self?.showLoader() : self?.hideLoader()
        })
    }

}

// MARK: - UITableViewDelegate

extension CustomListsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewModel = viewModel else { return }
        coordinator?.showListDetail(for: viewModel.list(at: indexPath.row))
    }

}
