//
//  CustomListDetailViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/19/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class CustomListDetailViewController: UIViewController, SegueHandler {
    
    @IBOutlet weak var navigationBarPlaceholderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var loadingFooterView: LoadingFooterView = {
        let footerView = LoadingFooterView()
        footerView.frame = LoadingFooterView.recommendedFrame
        footerView.startAnimating()
        return footerView
    }()
    
    private var headerView: CustomListDetailHeaderView!
    
    private var dataSource: CustomListDetailDataSource!
    private var displayedCellsIndexPaths = Set<IndexPath>()
    
    /// Used to determinate if the header view is being presented or not.
    private var tableViewContentOffsetY: CGFloat = 0
    
    private var isNavigationBarConfigured: Bool = false
    
    private var navBarAnimator: UIViewPropertyAnimator!
    
    var viewModel: CustomListDetailViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    // MARK: - Lifecycle
    
    deinit {
        print("CustomListDetailViewController")
        navBarAnimator.stopAnimation(true)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
        }, completion: { _ in
            self.setupTableViewHeader()
            self.configureScrollView(self.tableView, forceUpdate: true)
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.configureDynamicHeaderViewHeight()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBarStyle()
        guard !isNavigationBarConfigured else { return }
        isNavigationBarConfigured = true
        setClearNavigationBar()
        setupTableViewHeader()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = view.tintColor
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
        let backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
        navBarAnimator = UIViewPropertyAnimator(duration: 0.1, curve: .linear, animations: {
            self.navigationBarPlaceholderView.alpha = 1
        })
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        tableView.registerNib(cellType: MovieTableViewCell.self)
    }
    
    private func setupTableViewHeader() {
        headerView = CustomListDetailHeaderView.loadFromNib()
        headerView.viewModel = viewModel?.buildHeaderViewModel()
        
        headerView.setHeaderOffset(navigationBarHeight)
        headerView.frame = CGRect(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height - navigationBarHeight)
        
        tableView.clipsToBounds = false
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
    
    private func configureNavigationBarStyle() {
        if navigationItem.title != nil {
            navigationController?.navigationBar.barStyle = .default
            navigationController?.navigationBar.tintColor = view.tintColor
        } else {
            navigationController?.navigationBar.barStyle = .black
            navigationController?.navigationBar.tintColor = .white
        }
    }
    
    private func showNavigationBar() {
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.tintColor = self.view.tintColor
        self.restoreClearNavigationBar(with: .white)
    }
    
    private func hideNavigationBar() {
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = .white
        self.setClearNavigationBar()
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
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
        configureScrollView(scrollView)
    }
    
    private func configureScrollView(_ scrollView: UIScrollView, forceUpdate: Bool = false) {
        guard let tableView = scrollView as? UITableView,
            let headerView = tableView.tableHeaderView as? CustomListDetailHeaderView else {
                return
        }
        let contentOffsetY = tableView.contentOffset.y
        let headerHeight = headerView.frame.size.height - 40.0
        
        if contentOffsetY >= 0 {
            navBarAnimator.fractionComplete = min(abs(contentOffsetY) / 180.0, 1.0)
        } else {
            navBarAnimator.fractionComplete = 0
        }
        
        // Stertchy header
        let height = headerView.initialHeightConstraintConstant - contentOffsetY
        let newHeight = min(max(height, 40), 400)
        let newOffSet = newHeight - headerView.initialHeightConstraintConstant
        
        headerView.setHeaderOffset(navigationBarHeight + newOffSet)
        headerView.setPosterHeight(newHeight)
        
        // Navigation bar title
        let shouldShowTitle = forceUpdate ? true : tableViewContentOffsetY <= headerHeight
        let shouldHideTitle = forceUpdate ? true : tableViewContentOffsetY > headerHeight
        
        if shouldShowTitle && contentOffsetY > headerHeight {
            showNavigationBar()
            setTitleAnimated(viewModel?.name)
        } else if shouldHideTitle && contentOffsetY <= headerHeight {
            hideNavigationBar()
            setTitleAnimated(nil)
        }
        
        tableViewContentOffsetY = scrollView.contentOffset.y
    }
    
}

// MARK: - Segue Identifiers

extension CustomListDetailViewController {
    
    enum SegueIdentifier: String {
        case movieDetail = "MovieDetailSegue"
    }
    
}
