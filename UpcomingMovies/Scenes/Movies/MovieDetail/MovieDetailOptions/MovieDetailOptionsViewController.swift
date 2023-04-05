//
//  MovieDetailOptionsViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/04/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import UIKit

class MovieDetailOptionsViewController: UIViewController {

    @IBOutlet private weak var optionsStackView: UIStackView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - Private
    
    private func configureMovieOptions(_ options: [MovieDetailOption]) {
        guard optionsStackView.arrangedSubviews.isEmpty else { return }
        let optionsViews = options.map { MovieDetailOptionView(option: $0) }
        for optionView in optionsViews {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(optionAction(_:)))
            optionView.addGestureRecognizer(tapGesture)
            optionsStackView.addArrangedSubview(optionView)
        }
    }

    // MARK: - Selectors

    @objc private func optionAction(_ sender: UITapGestureRecognizer) {
        guard let sender = sender.view as? MovieDetailOptionView else { return }
        let movieDetailOption = sender.option
        coordinator?.showMovieOption(movieDetailOption)
    }

}
