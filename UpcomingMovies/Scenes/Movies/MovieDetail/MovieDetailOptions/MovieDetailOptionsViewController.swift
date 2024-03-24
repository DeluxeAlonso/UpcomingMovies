//
//  MovieDetailOptionsViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/04/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import UIKit

protocol MovieDetailOptionsViewControllerDelegate: UIViewController {

    func movieDetailOptionsViewController(_ movieDetailOptionsViewController: MovieDetailOptionsViewController,
                                          didSelectOption option: MovieDetailOption)

}

final class MovieDetailOptionsViewController: UIViewController, Storyboarded {

    @IBOutlet private weak var optionsStackView: UIStackView!

    static var storyboardName: String = "MovieDetail"

    var viewModel: MovieDetailOptionsViewModelProtocol?
    weak var delegate: MovieDetailOptionsViewControllerDelegate?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Private

    private func configureUI() {
        guard let viewModel else { return }
        if !optionsStackView.arrangedSubviews.isEmpty {
            optionsStackView.arrangedSubviews.forEach(self.optionsStackView.removeArrangedSubview)
        }
        let optionsViews = viewModel.options.map { MovieDetailOptionView(option: $0) }
        for optionView in optionsViews {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(optionAction(_:)))
            optionView.addGestureRecognizer(tapGesture)
            optionsStackView.addArrangedSubview(optionView)
        }
    }

    // MARK: - Selectors

    @objc func optionAction(_ sender: UITapGestureRecognizer) {
        guard let sender = sender.view as? MovieDetailOptionView else { return }
        let movieDetailOption = sender.option
        delegate?.movieDetailOptionsViewController(self, didSelectOption: movieDetailOption)
    }

}
