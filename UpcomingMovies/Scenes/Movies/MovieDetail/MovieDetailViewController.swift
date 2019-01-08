//
//  MovieDetailViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var viewModel: MovieDetailViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "Movie detail"
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let shareBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareBarButtonAction))
        navigationItem.rightBarButtonItem = shareBarButtonItem
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        guard let viewModel = viewModel else {
            return
        }
        titleLabel.text = viewModel.name
        genreLabel.text = viewModel.genre
        releaseDateLabel.text = viewModel.releaseDate
        backdropImageView.kf.indicatorType = .activity
        backdropImageView.kf.setImage(with: viewModel.fullBackdropPath)
        overviewLabel.text = viewModel.overview
    }
    
    // MARK: - Selectors
    
    @objc func shareBarButtonAction() {
        guard let movieName = viewModel?.name else { return }
        let shareText = "Come with me to watch \(movieName)!"
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }

}
