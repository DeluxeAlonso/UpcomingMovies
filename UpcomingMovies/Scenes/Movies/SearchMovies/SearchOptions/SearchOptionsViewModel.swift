//
//  SearchOptionsViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/15/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

final class SearchOptionsViewModel: SearchOptionsViewModelProtocol {

    // MARK: - Dependencies

    private var interactor: SearchOptionsInteractorProtocol

    // MARK: - Reactive properties

    let viewState: BehaviorBindable<SearchOptionsViewState> = BehaviorBindable(.emptyMovieVisits)

    let needsContentReload: PublishBindable<Void> = PublishBindable()
    let updateVisitedMovies: PublishBindable<Int> = PublishBindable()

    let selectedDefaultSearchOption: PublishBindable<DefaultSearchOption> = PublishBindable()
    let selectedMovieGenre: PublishBindable<(Int, String)> = PublishBindable()
    let selectedRecentlyVisitedMovie: PublishBindable<(Int, String)> = PublishBindable()

    // MARK: - Computed properties

    var visitedMovieCells: [VisitedMovieCellViewModelProtocol] {
        movieVisits.map { VisitedMovieCellViewModel(movieVisit: $0) }
    }

    var genreCells: [GenreSearchOptionCellViewModelProtocol] {
        genres.map { GenreSearchOptionCellViewModel(genre: $0) }
    }

    var defaultSearchOptionsCells: [DefaultSearchOptionCellViewModelProtocol] {
        defaultSearchOptions.map { DefaultSearchOptionCellViewModel(defaultSearchOption: $0) }
    }

    // MARK: - Stored properties

    private var movieVisits: [MovieVisitProtocol] = []
    private var genres: [GenreProtocol] = []
    private let defaultSearchOptions: [DefaultSearchOption] = [.popular, .topRated]

    // MARK: - Initializers

    init(interactor: SearchOptionsInteractorProtocol) {
        self.interactor = interactor

        self.interactor.didUpdateMovieVisit = { [weak self] in
            guard let self = self else { return }
            self.loadVisitedMovies()
        }
    }

    // MARK: - SearchOptionsViewModelProtocol

    func loadGenres() {
        interactor.getGenres(completion: { [weak self] result in
            guard let self = self else { return }
            guard let genres = result.wrappedValue else { return }
            self.genres = genres
            self.needsContentReload.send()
        })
    }

    func loadVisitedMovies() {
        interactor.getMovieVisits { [weak self] result in
            guard let self = self else { return }
            guard let movieVisits = result.wrappedValue else { return }

            self.movieVisits = movieVisits
            let viewStateChanged = self.configureViewState(movieVisits: movieVisits)
            // If the state changed we reload the entire table view
            if viewStateChanged {
                self.needsContentReload.send()
            } else {
                guard let index = self.sectionIndex(for: .recentlyVisited) else { return }
                self.updateVisitedMovies.send(index)
            }
        }
    }

    func section(at index: Int) -> SearchOptionsSection {
        viewState.value.sections[index]
    }

    func sectionIndex(for section: SearchOptionsSection) -> Int? {
        let sections = viewState.value.sections
        return sections.firstIndex(of: section)
    }

    func buildRecentlyVisitedMoviesCell() -> RecentlyVisitedMoviesCellViewModelProtocol {
        RecentlyVisitedMoviesCellViewModel(visitedMovieCells: visitedMovieCells)
    }

    func getDefaultSearchSelection(by index: Int) {
        let defaultSearchOption = defaultSearchOptions[index]
        selectedDefaultSearchOption.send(defaultSearchOption)
    }

    func getMovieGenreSelection(by index: Int) {
        let selectedGenre = genres[index]
        selectedMovieGenre.send((selectedGenre.id, selectedGenre.name))
    }

    func getRecentlyVisitedMovieSelection(by index: Int) {
        let selectedVisitedMovie = movieVisits[index]
        selectedRecentlyVisitedMovie.send((selectedVisitedMovie.id, selectedVisitedMovie.title))
    }

    // MARK: - Private

    /**
     * Configures the state of the view according to the saved movie visits
     * quantity. Returns true if the state changed and false if not.
     */
    private func configureViewState(movieVisits: [MovieVisitProtocol]) -> Bool {
        let oldViewState = viewState.value
        viewState.value = movieVisits.isEmpty ? .emptyMovieVisits : .populatedMovieVisits

        return oldViewState != viewState.value
    }

}
