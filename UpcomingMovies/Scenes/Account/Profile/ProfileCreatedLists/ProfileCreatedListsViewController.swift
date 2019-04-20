//
//  ProfileCreatedListsViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/19/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class ProfileCreatedListsViewController: UIViewController, Displayable, Loadable {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource: SimpleTableViewDataSource<CreatedListCellViewModel>!
    
    var loaderView: RadarView!
    
    var viewModel: ProfileCreatedListsViewModel? {
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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100.0
        tableView.delegate = self
        tableView.registerNib(cellType: CreatedListTableViewCell.self)
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
        hideDisplayedView()
        switch state {
        case .populated, .paging, .initial:
            tableView.tableFooterView = UIView()
        case .empty:
            presentEmptyView(with: "No created lists to show")
        case .error(let error):
            presentErrorView(with: error.description,
                             errorHandler: { [weak self] in
                                self?.viewModel?.getCreatedLists()
            })
        }
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        title = viewModel?.title
        viewModel?.viewState.bindAndFire({ [weak self] state in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.configureView(withState: state)
                strongSelf.reloadTableView()
            }
        })
        viewModel?.startLoading = { [weak self] start in
            start ? self?.showLoader() : self?.hideLoader()
        }
        viewModel?.getCreatedLists()
    }

}

// MARK: - UITableViewDelegate

extension ProfileCreatedListsViewController: UITableViewDelegate {
    
}
