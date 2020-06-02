//
//  MovieReviewDetailViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 5/31/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

class MovieReviewDetailViewController: UIViewController {
    
    @IBOutlet weak var contentLabel: UILabel!
    
    var viewModel: MovieReviewDetailViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        setupLabels()
    }
    
    private func setupLabels() {
        contentLabel.numberOfLines = 0
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        title = viewModel?.author
        contentLabel.text = viewModel?.content
    }
    
    // MARK: - Actions
    
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
