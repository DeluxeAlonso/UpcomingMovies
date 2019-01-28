//
//  MovieDetailViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterContainerView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var viewModel: MovieDetailViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    private var managedObjectContext: NSManagedObjectContext {
        guard let appDelegate = appDelegate else { fatalError() }
        return appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "Movie detail"
        setupNavigationBar()
        posterContainerView.setShadowBorder()
    }
    
    private func setupNavigationBar() {
        let shareBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareBarButtonAction))
        navigationItem.rightBarButtonItem = shareBarButtonItem
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.title
        genreLabel.text = viewModel.genre
        releaseDateLabel.text = viewModel.releaseDate
        
        backdropImageView.kf.indicatorType = .activity
        backdropImageView.kf.setImage(with: viewModel.fullBackdropPath)
        
        posterImageView.kf.indicatorType = .activity
        posterImageView.kf.setImage(with: viewModel.fullPosterPath)
        
        overviewLabel.text = viewModel.overview
        viewModel.saveVisitedMovie(managedObjectContext)
    }
    
    // MARK: - Selectors
    
    @objc func shareBarButtonAction() {
        guard let movieTitle = viewModel?.title else { return }
        let shareText = "Come with me to watch \(movieTitle)!"
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }

}
