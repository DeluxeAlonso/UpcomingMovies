//
//  CustomListDetailViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/19/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class CustomListDetailViewController: UIViewController, SegueHandler {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var posterImageViewHeightConstraint: NSLayoutConstraint!
    
    private lazy var loadingFooterView: LoadingFooterView = {
        let footerView = LoadingFooterView()
        footerView.frame = LoadingFooterView.recommendedFrame
        footerView.startAnimating()
        return footerView
    }()
    
    private var dataSource: CustomListDetailDataSource!
    private var displayedCellsIndexPaths = Set<IndexPath>()
    
    private var showNavBarAnimator: UIViewPropertyAnimator!
    private var hideNavBarAnimator: UIViewPropertyAnimator!
    
    /// Used to determinate if the header view is being presented or not.
    private var tableViewContentOffsetY: CGFloat = 0
    
    private var currentTableViewTopInset: CGFloat!
    
    private var initialHeightContraintConstant: CGFloat!
    
    private var isNavigationBarConfigured: Bool = false
    
    var viewModel: CustomListDetailViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    // MARK: - Lifecycle

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
        }, completion: { _ in
            self.configureContentInset()
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.configureDynamicHeaderViewHeight()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = isTitlePresented() ? .default : .black
        guard !isNavigationBarConfigured else { return }
        isNavigationBarConfigured = true
        setClearNavigationBar()
        configureContentInset()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.barStyle = .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        initialHeightContraintConstant = posterImageViewHeightConstraint.constant
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        tableView.registerNib(cellType: MovieTableViewCell.self)
    }
    
    private func setupTableViewHeader() {
        let headerView = CustomListDetailHeaderView.loadFromNib()
        headerView.viewModel = viewModel?.buildHeaderViewModel()
        tableView.tableHeaderView = headerView
    }
    
    private func reloadTableView() {
        guard let viewModel = viewModel else { return }
        dataSource = CustomListDetailDataSource(viewModel: viewModel)
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    private func configureView(with state: CustomListDetailViewModel.ViewState) {
        switch state {
        case .empty:
            tableView.tableFooterView = CustomFooterView(message: "No movies to show")
        case .populated:
            tableView.tableFooterView = UIView()
        case .loading:
            tableView.tableFooterView = loadingFooterView
        case .error(let error):
            tableView.tableFooterView = CustomFooterView(message: error.description)
        }
    }
    
    private func configureContentInset() {
        if let top = navigationController?.navigationBar.intrinsicContentSize.height {
            let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
            currentTableViewTopInset = initialHeightContraintConstant - top - statusBarHeight
            tableView.contentInset = .init(top: currentTableViewTopInset,
                                           left: 0, bottom: 0, right: 0)
        }
    }
    
    private func showNavigationBar() {
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.navigationController?.navigationBar.barStyle = .default
            self?.restoreClearNavigationBar(with: .white)
            }, completion: nil)
    }
    
    private func hideNavigationBar() {
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.navigationController?.navigationBar.barStyle = .black
            self?.setClearNavigationBar()
        }, completion: nil)
    }
    
    private func isTitlePresented() -> Bool {
        return navigationItem.title != nil
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
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .movieDetail:
            guard let viewController = segue.destination as? MovieDetailViewController else { fatalError() }
            guard let indexPath = sender as? IndexPath else { return }
            _ = viewController.view
            viewController.viewModel = viewModel?.buildDetailViewModel(at: indexPath.row)
        }
    }

}

// MARK: - UITableViewDelegate

extension CustomListDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: SegueIdentifier.movieDetail.rawValue,
                     sender: indexPath)
    }
    
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
        let contentOffsetY = scrollView.contentOffset.y
        let headerHeight = headerView.frame.size.height - 40.0
        
        configureScrollView(scrollView, for: contentOffsetY, and: headerHeight)
        
        tableViewContentOffsetY = contentOffsetY
    }
    
    private func configureScrollView(_ scrollView: UIScrollView,
                                     for contentOffsetY: CGFloat,
                                     and headerHeight: CGFloat) {
        // Stretchy header
        let height = initialHeightContraintConstant - (contentOffsetY + currentTableViewTopInset)
        
        let newHeight = min(max(height, 40), 400)
        posterImageViewHeightConstraint.constant = newHeight
        
        // Content Inset
        if contentOffsetY <= 0 && abs(contentOffsetY) <= currentTableViewTopInset {
            scrollView.contentInset.top = abs(contentOffsetY)
        } else if contentOffsetY > 0 {
            scrollView.contentInset.top = 0
        }
        
        // Navigation bar title
        if tableViewContentOffsetY <= headerHeight && contentOffsetY > headerHeight {
            showNavigationBar()
            setTitleAnimated(viewModel?.name)
        } else if tableViewContentOffsetY > headerHeight && contentOffsetY <= headerHeight {
            hideNavigationBar()
            setTitleAnimated(nil)
        }
    }
    
}

// MARK: - Segue Identifiers

extension CustomListDetailViewController {
    
    enum SegueIdentifier: String {
        case movieDetail = "MovieDetailSegue"
    }
    
}
