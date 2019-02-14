//
//  MovieCreditsViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/13/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class MovieCreditsViewController: UIViewController, Retryable {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: MovieCreditsViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    private var segmentedControl: UISegmentedControl!
    private var dataSource: SimpleCollectionViewDataSource<MovieCreditCellViewModel>!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        setupNavigationBar()
        setupCollectionView()
    }
    
    private func setupNavigationBar() {
        let items = ["Cast", "Crew"]
        segmentedControl = UISegmentedControl(items: items)
        segmentedControl.setWidth(100.0, forSegmentAt: 0)
        segmentedControl.setWidth(100.0, forSegmentAt: 1)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        navigationItem.titleView = segmentedControl
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.registerNib(cellType: MovieCreditCollectionViewCell.self)
        collectionView.backgroundView = LoadingFooterView()
    }
    
    private func reloadCollectionView(cells: [MovieCreditCellViewModel]) {
        dataSource = SimpleCollectionViewDataSource.make(for: cells)
        collectionView.dataSource = dataSource
        collectionView.reloadData()
    }
    
    private func configureView(with state: MovieCreditsViewModel.ViewState) {
        switch state {
        case .loading:
            collectionView.backgroundView = LoadingFooterView()
            hideErrorView()
        case .populated, .empty:
            collectionView.backgroundView = nil
            hideErrorView()
        case .error(let error):
            presentFullScreenErrorView(withErrorMessage: error.localizedDescription,
                                       errorHandler: { [weak self] in
                               self?.viewModel?.getMovieCredits()
            })
        }
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        guard let viewModel = viewModel else { return }
        title = viewModel.movieTitle
        viewModel.getMovieCredits()
        viewModel.viewState.bind({ [weak self] state in
            guard let strongSelf = self else { return }
            strongSelf.configureView(with: state)
            strongSelf.reloadCollectionView(cells: viewModel.castCells)
        })
    }
    
    // MARK: - Selectors
    
    @objc func segmentedControlValueChanged() {
        guard let viewModel = viewModel else { return }
        let index = segmentedControl.selectedSegmentIndex
        let cells = index == 0 ? viewModel.castCells : viewModel.crewCells
        reloadCollectionView(cells: cells)
    }

}

// MARK: - UICollectionViewDelegate

extension MovieCreditsViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MovieCreditsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let posterHeight: Double = 200.0
        let posterWidth: Double = 100.0
        return CGSize(width: posterWidth, height: posterHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
    }

}
