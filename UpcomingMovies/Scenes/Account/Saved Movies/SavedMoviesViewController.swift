//
//  SavedMoviesViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit
import CollectionViewSlantedLayout
import UpcomingMoviesDomain

class SavedMoviesViewController: UIViewController, Storyboarded, PlaceholderDisplayable, SegueHandler, Loadable {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    static var storyboardName = "Account"
    
    private var dataSource: SimpleCollectionViewDataSource<SavedMovieCellViewModel>!
    private var prefetchDataSource: CollectionViewDataSourcePrefetching!
    
    var loaderView: RadarView!
    
    var viewModel: SavedMoviesViewModel?
    weak var coordinator: SavedMoviesCoordinator?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindables()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let selectedViewController = tabBarController?.selectedViewController,
            selectedViewController == self || selectedViewController == navigationController else {
            return
        }
        updateCollectionViewLayout()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        setupCollectionView()
        setupRefreshControl()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.registerNib(cellType: SavedMovieCollectionViewCell.self)
        setupCollectionViewLayout()
    }
    
    private func setupCollectionViewLayout() {
        let layout = CollectionViewSlantedLayout()
        layout.isFirstCellExcluded = true
        layout.isLastCellExcluded = true
        collectionView.collectionViewLayout = layout
    }
    
    private func updateCollectionViewLayout() {
        if let layout = collectionView.collectionViewLayout as? CollectionViewSlantedLayout {
            layout.itemSize = 225
        }
    }
    
    private func setupRefreshControl() {
        collectionView.refreshControl = DefaultRefreshControl(tintColor: ColorPalette.lightBlueColor,
                                                              backgroundColor: collectionView.backgroundColor,
                                                              refreshHandler: { [weak self] in
                                                                self?.viewModel?.refreshCollectionList()
        })
    }
    
    private func reloadCollectionView() {
        guard let viewModel = viewModel else { return }
        dataSource = SimpleCollectionViewDataSource.make(for: viewModel.movieCells)
        
        prefetchDataSource = CollectionViewDataSourcePrefetching(cellCount: viewModel.movieCells.count,
                                                       needsPrefetch: viewModel.needsPrefetch,
                                                       prefetchHandler: { [weak self] in
                                                        self?.viewModel?.getCollectionList()
        })
        
        collectionView.dataSource = dataSource
        collectionView.prefetchDataSource = prefetchDataSource
        
        collectionView.reloadData()
        collectionView.refreshControl?.endRefreshing()
    }
    
    /**
     * Configures the tableview footer given the current state of the view.
     */
    private func configureView(withState state: SimpleViewState<Movie>) {
        switch state {
        case .populated, .paging, .initial:
            hideDisplayedPlaceholderView()
            collectionView.backgroundView = UIView(frame: .zero)
        case .empty:
            presentEmptyView(with: "No movies to show")
        case .error(let error):
            presentRetryView(with: error.localizedDescription,
                                       errorHandler: { [weak self] in
                                        self?.viewModel?.refreshCollectionList()
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
                strongSelf.updateCollectionViewLayout()
                strongSelf.reloadCollectionView()
            }
        })
        viewModel?.startLoading.bind({ [weak self] start in
            start ? self?.showLoader() : self?.hideLoader()
        })
        viewModel?.getCollectionList()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationController?.delegate = nil
        switch segueIdentifier(for: segue) {
        case .movieDetail:
            guard let viewController = segue.destination as? MovieDetailViewController,
                let index = sender as? Int else { fatalError() }
            _ = viewController.view
            viewController.viewModel = viewModel?.buildDetailViewModel(atIndex: index)
        }
    }
    
}

// MARK: - UICollectionViewDelegate

extension SavedMoviesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: SegueIdentifier.movieDetail.rawValue,
                     sender: indexPath.row)
    }
    
}

// MARK: - Segue Identifiers

extension SavedMoviesViewController {
    
    enum SegueIdentifier: String {
        case movieDetail = "MovieDetailSegue"
    }
    
}
