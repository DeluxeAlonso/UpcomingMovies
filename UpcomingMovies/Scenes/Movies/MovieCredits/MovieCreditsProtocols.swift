//
//  MovieCreditsProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

protocol MovieCreditsViewModelProtocol {

    var movieTitle: String { get }

    var viewState: AnyBehaviorBindable<MovieCreditsViewState> { get }
    var didToggleSection: AnyPublishBindable<Int> { get }
    var startLoading: AnyBehaviorBindable<Bool> { get }

    var emptyCreditResultsTitle: String { get }

    func numberOfSections() -> Int
    func numberOfItems(for section: Int) -> Int

    func creditModel(for section: Int, and index: Int) -> MovieCreditCellViewModelProtocol
    func headerModel(for index: Int) -> CollapsibleHeaderViewModel

    func toggleSection(_ section: Int)
    func getMovieCredits(showLoader: Bool)

}

protocol MovieCreditsInteractorProtocol {

    func getMovieCredits(for movieId: Int, page: Int?,
                         completion: @escaping (Result<MovieCreditsProtocol, Error>) -> Void)

}

protocol MovieCreditsSectionManagerProtocol {

    var sections: [MovieCreditsCollapsibleSection] { get }

    func updateSection(type: MovieCreditsViewSection, enabled: Bool)
    func toggleSection(at index: Int)

}

protocol MovieCreditsCoordinatorProtocol: AnyObject {}
