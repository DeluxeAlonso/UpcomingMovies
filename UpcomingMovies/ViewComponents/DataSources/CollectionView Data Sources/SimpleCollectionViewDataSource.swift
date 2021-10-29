//
//  SimpleCollectionViewDataSource.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/9/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

final class SimpleCollectionViewDataSource<ViewModel>: NSObject, UICollectionViewDataSource {

    typealias CellConfigurator = (ViewModel, UICollectionViewCell) -> Void

    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator
    private let cellViewModels: [ViewModel]

    // MARK: - Initializers

    init(cellViewModels: [ViewModel], reuseIdentifier: String, cellConfigurator: @escaping CellConfigurator) {
        self.cellViewModels = cellViewModels
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = cellViewModels[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cellConfigurator(viewModel, cell)
        return cell
    }

}

extension SimpleCollectionViewDataSource where ViewModel == UpcomingMovieCellViewModelProtocol {

    static func make(for cellViewModels: [ViewModel],
                     presentationMode: UpcomingMoviesViewController.PresentationMode) -> SimpleCollectionViewDataSource {
        return SimpleCollectionViewDataSource(cellViewModels: cellViewModels,
                                              reuseIdentifier: presentationMode.cellIdentifier,
                                              cellConfigurator: { (viewModel, cell) in
                                                var cell = cell as! UpcomingMovieCollectionViewCellProtocol
                                                cell.viewModel = viewModel
                                              })
    }

}

extension SimpleCollectionViewDataSource where ViewModel == MovieCreditCellViewModel {

    static func make(for cellViewModels: [MovieCreditCellViewModel],
                     reuseIdentifier: String = MovieCreditCell.dequeueIdentifier) -> SimpleCollectionViewDataSource {
        return SimpleCollectionViewDataSource(cellViewModels: cellViewModels,
                                              reuseIdentifier: reuseIdentifier,
                                              cellConfigurator: { (viewModel, cell) in
                                                let cell = cell as! MovieCreditCell
                                                cell.viewModel = viewModel
                                              })
    }

}

extension SimpleCollectionViewDataSource where ViewModel == SavedMovieCellViewModelProtocol {

    static func make(for cellViewModels: [ViewModel],
                     reuseIdentifier: String = SavedMovieCollectionViewCell.dequeueIdentifier) -> SimpleCollectionViewDataSource {
        return SimpleCollectionViewDataSource(cellViewModels: cellViewModels,
                                              reuseIdentifier: reuseIdentifier,
                                              cellConfigurator: { (viewModel, cell) in
                                                let cell = cell as! SavedMovieCollectionViewCell
                                                cell.viewModel = viewModel
                                              })
    }

}
