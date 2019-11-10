//
//  CustomListsViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/19/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

class CustomListsViewController: UIViewController, PlaceholderDisplayable, SegueHandler, Loadable {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource: SimpleTableViewDataSource<CustomListCellViewModel>!
    
    var loaderView: RadarView!
    
    var viewModel: CustomListsViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let textAttributes: [NSAttributedString.Key: UIColor]
        if #available(iOS 13.0, *) {
            textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        } else {
            textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        }
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    // MARK: - Private
    
    private func setupUI() {
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
            presentErrorView(with: error.localizedDescription,
                             errorHandler: { [weak self] in
                                self?.viewModel?.refreshCustomLists()
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
        viewModel?.startLoading.bind({ [weak self] start in
            start ? self?.showLoader() : self?.hideLoader()
        })
        viewModel?.getCustomLists()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .customListDetail:
            guard let viewController = segue.destination as? CustomListDetailViewController else { fatalError() }
            guard let indexPath = sender as? IndexPath else { return }
            _ = viewController.view
            viewController.viewModel = viewModel?.buildDetailViewModel(atIndex: indexPath.row)
        }
    }

}

// MARK: - UITableViewDelegate

extension CustomListsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: SegueIdentifier.customListDetail.rawValue,
                     sender: indexPath)
    }
    
}

// MARK: - Segue Identifiers

extension CustomListsViewController {
    
    enum SegueIdentifier: String {
        case customListDetail = "CustomListDetailSegue"
    }
    
}
