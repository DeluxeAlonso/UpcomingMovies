//
//  MovieDetailPosterViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 18/04/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import UIKit

protocol MovieDetailPosterViewControllerDelegate: UIViewController {

    func movieDetailPosterViewController(_ movieDetailPosterViewController: MovieDetailPosterViewController,
                                         transitionContainerView: UIView)

}

final class MovieDetailPosterViewController: UIViewController, Storyboarded {

    @IBOutlet private weak var backdropImageView: UIImageView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private(set) weak var transitionContainerView: UIView!

    static var storyboardName: String = "MovieDetail"

    var viewModel: MovieDetailPosterViewModelProtocol?
    weak var delegate: MovieDetailPosterViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        backdropImageView.setImage(with: viewModel?.backdropURL)
        posterImageView.setImage(with: viewModel?.posterURL)

        transitionContainerView.setShadowBorder()
        delegate?.movieDetailPosterViewController(self, transitionContainerView: transitionContainerView)
    }

    func update(with viewModel: MovieDetailPosterViewModelProtocol) {
        self.viewModel = viewModel
        setupUI()
    }

}
