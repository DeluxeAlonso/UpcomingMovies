//
//  SearchOptionsViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/15/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

// TODO: - Add tests for this class
final class SearchOptionsViewModel: SearchOptionsViewModelProtocol {

    // MARK: - Dependencies

    private var interactor: SearchOptionsInteractorProtocol

    // MARK: - Reactive properties

    let viewState: Bindable<SearchOptionsViewState> = Bindable(.emptyMovieVisits)

    var needsContentReload: Bindable<Void> = Bindable(())
    var updateVisitedMovies: Bindable<Int?> = Bindable(nil)

    var selectedDefaultSearchOption: Bindable<DefaultSearchOption?> = Bindable(nil)
    var selectedMovieGenre: Bindable<(Int?, String?)> = Bindable((nil, nil))
    // TODO: - Move this to Bindable
    var selectedRecentlyVisitedMovie: ((Int, String) -> Void)?

    // MARK: - Computed properties

    var visitedMovieCells: [VisitedMovieCellViewModelProtocol] {
        return movieVisits.map { VisitedMovieCellViewModel(movieVisit: $0) }
    }

    var genreCells: [GenreSearchOptionCellViewModelProtocol] {
        return genres.map { GenreSearchOptionCellViewModel(genre: $0) }
    }

    var defaultSearchOptionsCells: [DefaultSearchOptionCellViewModelProtocol] {
        return defaultSearchOptions.map { DefaultSearchOptionCellViewModel(defaultSearchOption: $0) }
    }

    // MARK: - Stored properties

    private var movieVisits: [MovieVisit] = []
    private var genres: [Genre] = []
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
            guard let genres = try? result.get() else { return }
            self.genres = genres
            self.needsContentReload.fire()
        })
    }

    func loadVisitedMovies() {
        interactor.getMovieVisits { [weak self] result in
            guard let self = self else { return }
            guard let movieVisits = try? result.get() else { return }

            self.movieVisits = movieVisits
            let viewStateChanged = self.configureViewState(movieVisits: movieVisits)
            // If the state changed we reload the entire table view
            if viewStateChanged {
                self.needsContentReload.fire()
            } else {
                let index = self.sectionIndex(for: .recentlyVisited)
                self.updateVisitedMovies.value = index
            }
        }
    }

    func section(at index: Int) -> SearchOptionsSection {
        return viewState.value.sections[index]
    }

    func sectionIndex(for section: SearchOptionsSection) -> Int? {
        let sections = viewState.value.sections
        return sections.firstIndex(of: section)
    }

    func buildRecentlyVisitedMoviesCell() -> RecentlyVisitedMoviesCellViewModelProtocol {
        return RecentlyVisitedMoviesCellViewModel(visitedMovieCells: visitedMovieCells)
    }

    func getDefaultSearchSelection(by index: Int) {
        let defaultSearchOption = defaultSearchOptions[index]
        selectedDefaultSearchOption.value = defaultSearchOption
    }

    func getMovieGenreSelection(by index: Int) {
        let selectedGenre = genres[index]
        selectedMovieGenre.value = (selectedGenre.id, selectedGenre.name)
    }

    func getRecentlyVisitedMovieSelection(by index: Int) {
        let selectedVisitedMovie = movieVisits[index]
        selectedRecentlyVisitedMovie?(selectedVisitedMovie.id, selectedVisitedMovie.title)
    }

    // MARK: - Private

    /**
     * Configures the state of the view according to the saved movie visits
     * quantity. Returns true if the state changed and false if not.
     */
    private func configureViewState(movieVisits: [MovieVisit]) -> Bool {
        let oldViewState = viewState.value
        viewState.value = movieVisits.isEmpty ? .emptyMovieVisits : .populatedMovieVisits

        return oldViewState != viewState.value
    }

}
