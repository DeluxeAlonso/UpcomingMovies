//
//  RecentlyVisitedMoviesTableViewCell.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/16/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

protocol RecentlyVisitedMoviesTableViewCellDelegate: AnyObject {

    func recentlyVisitedMoviesTableViewCell(_ recentlyVisitedMoviesTableViewCell: RecentlyVisitedMoviesTableViewCell,
                                            didSelectMovieAt indexPath: IndexPath)

}

final class RecentlyVisitedMoviesTableViewCell: UITableViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!

    weak var delegate: RecentlyVisitedMoviesTableViewCellDelegate?

    var viewModel: RecentlyVisitedMoviesCellViewModelProtocol? {
        didSet {
            setupBindables()
        }
    }

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Private

    private func setupUI() {
        backgroundColor = ColorPalette.groupedCellBackgroundColor
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerNib(cellType: VisitedMovieCollectionViewCell.self)
    }

    // MARK: - Reactive Behavior

    private func setupBindables() {
        collectionView.reloadData()
    }

}

// MARK: - UICollectionViewDataSource

extension RecentlyVisitedMoviesTableViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.visitedMovieCells.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else { fatalError() }
        let cell = collectionView.dequeueReusableCell(with: VisitedMovieCollectionViewCell.self, for: indexPath)
        cell.viewModel = viewModel.visitedMovieCells[indexPath.row]
        return cell
    }

}

// MARK: - UICollectionViewDelegate

extension RecentlyVisitedMoviesTableViewCell: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.recentlyVisitedMoviesTableViewCell(self, didSelectMovieAt: indexPath)
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension RecentlyVisitedMoviesTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let posterHeight: Double = Double(contentView.frame.height) - Constants.cellHeightOffset
        let posterWidth: Double = posterHeight / UIConstants.posterAspectRatio
        return CGSize(width: posterWidth, height: posterHeight)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: Constants.cellsVerticalMargin, bottom: 0.0, right: Constants.cellsVerticalMargin)
    }

}

// MARK: - Constants

extension RecentlyVisitedMoviesTableViewCell {

    struct Constants {
        static let cellsVerticalMargin: CGFloat = 16.0
        static let cellHeightOffset: Double = 20.0
    }

}
