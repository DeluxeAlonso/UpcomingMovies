//
//  CustomListDetailViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/19/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class CustomListDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var loadingFooterView: LoadingFooterView = {
        let footerView = LoadingFooterView()
        footerView.frame = LoadingFooterView.recommendedFrame
        footerView.startAnimating()
        return footerView
    }()
    
    private var displayedCellsIndexPaths = Set<IndexPath>()
    
    var lastY: CGFloat = 0
    
    var viewModel: CustomListDetailViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let headerView = tableView.tableHeaderView else { return }
        
        let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var headerFrame = headerView.frame
        
        // Comparison needed to avoid an infinite loop
        if height != headerFrame.size.height {
            headerFrame.size.height = height
            headerView.frame = headerFrame
            tableView.tableHeaderView = headerView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        let backItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(cellType: MovieTableViewCell.self)
    }
    
    private func setupTableViewHeader() {
        let headerView = CustomListDetailHeaderView.loadFromNib()
        headerView.viewModel = viewModel?.buildHeaderViewModel()
        tableView.tableHeaderView = headerView
    }
    
    private func reloadTableView() {
        tableView.reloadData()
    }
    
    private func configureView(with state: CustomListDetailViewModel.ViewState) {
        switch state {
        case .empty:
            tableView.tableFooterView = CustomFooterView(message: "No movies to show")
        case .populated:
            tableView.tableFooterView = UIView()
        case .loading:
            setupFooterTableView(tableView, with: loadingFooterView, and: LoadingFooterView.recommendedFrame)
        case .error(let error):
            tableView.tableFooterView = CustomFooterView(message: error.description)
        }
    }
    
    private func setupFooterTableView(_ tableView: UITableView, with view: UIView, and frame: CGRect) {
        let footerContainerView = UIView(frame: frame)
        footerContainerView.addSubview(view)
        tableView.tableFooterView = footerContainerView
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        setupTableViewHeader()
        viewModel?.viewState.bindAndFire({ [weak self] state in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.reloadTableView()
                strongSelf.configureView(with: state)
            }
        })
        viewModel?.getListDetail()
    }

}

// MARK: - UITableViewDataSource

extension CustomListDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.movieCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(with: MovieTableViewCell.self,
                                                 for: indexPath)
        cell.viewModel = viewModel.movieCells[indexPath.row]
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension CustomListDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = CustomListDetailSectionView.loadFromNib()
        view.viewModel = viewModel?.buildSectionViewModel()
        return view
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !displayedCellsIndexPaths.contains(indexPath) {
            displayedCellsIndexPaths.insert(indexPath)
            TableViewCellAnimator.fadeAnimate(cell: cell)
        }
    }
    
}

// MARK: - UIScrollViewDelegate

extension CustomListDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let tableView = scrollView as? UITableView,
            let headerView = tableView.tableHeaderView else {
                return
        }
        let currentY = scrollView.contentOffset.y
        let headerHeight = headerView.frame.size.height
        
        if lastY <= headerHeight && currentY > headerHeight {
            setTitleAnimated(viewModel?.name)
        } else if lastY > headerHeight && currentY <= headerHeight {
            setTitleAnimated(nil)
        }
        
        lastY = currentY
    }
    
}
