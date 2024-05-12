//
//  MovieDetailTitleViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 24/05/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

protocol MovieDetailTitleViewModelProtocol {

    var title: String { get }
    var subtitle: String? { get }
    var voteAverage: Double? { get }

    var showSubtitle: AnyBehaviorBindable<String?> { get }
    var showGenresNames: AnyBehaviorBindable<String?> { get }

}

final class MovieDetailTitleViewModel: MovieDetailTitleViewModelProtocol {

    let title: String
    let subtitle: String?
    let voteAverage: Double?
    let genreIds: [Int]

    let showSubtitle = BehaviorBindable<String?>(nil).eraseToAnyBindable()
    let showGenresNames = BehaviorBindable<String?>(nil).eraseToAnyBindable()

    private let interactor: MovieDetailInteractorProtocol

    init(_ renderContent: MovieDetailTitleRenderContent?, interactor: MovieDetailInteractorProtocol) {
        self.title = renderContent?.title ?? ""
        self.subtitle = renderContent?.releaseDate
        self.voteAverage = renderContent?.voteAverage
        self.genreIds = renderContent?.genreIds ?? []

        self.interactor = interactor

        if FeatureFlags.shared.showRedesignedMovieDetailScreen {
            getMoviesGenresNames(for: genreIds)
        }

        showSubtitle.value = FeatureFlags.shared.showRedesignedMovieDetailScreen ? subtitle : nil
    }

    private func getMoviesGenresNames(for genreIds: [Int]) {
        interactor.findGenres(for: genreIds, completion: { [weak self] result in
            guard let self = self else { return }
            let genres = result.wrappedValue
            self.showGenresNames.value = genres?.compactMap { $0.name }.joined(separator: " • ")
        })
    }

}
