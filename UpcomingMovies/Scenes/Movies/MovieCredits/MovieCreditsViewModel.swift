//
//  MovieCreditsViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/13/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class MovieCreditsViewModel: MovieCreditsViewModelProtocol {
    
    private let movieUseCase: MovieUseCaseProtocol
    private var sections = [MovieCreditsCollapsibleSection(type: .cast, opened: true),
                            MovieCreditsCollapsibleSection(type: .crew, opened: false)]
    
    var movieId: Int
    var movieTitle: String
    
    var viewState: Bindable<MovieCreditsViewState> = Bindable(.initial)
    var didToggleSection: Bindable<Int> = Bindable(0)
    var startLoading: Bindable<Bool> = Bindable(false)
    
    // MARK: - Initializers
    
    init(movieId: Int, movieTitle: String, useCaseProvider: UseCaseProviderProtocol) {
        self.movieId = movieId
        self.movieTitle = movieTitle

        self.movieUseCase = useCaseProvider.movieUseCase()
    }
    
    // MARK: - Public
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfItems(for section: Int) -> Int {
        let section = sections[section]
        guard section.opened else { return 0 }
        switch section.type {
        case .cast:
            return viewState.value.currentCast.count
        case .crew:
            return viewState.value.currentCrew.count
        }
    }
    
    func creditModel(for section: Int, and index: Int) -> MovieCreditCellViewModel {
        switch sections[section].type {
        case .cast:
            let cast = viewState.value.currentCast[index]
            return MovieCreditCellViewModel(cast: cast)
        case .crew:
            let crew = viewState.value.currentCrew[index]
            return MovieCreditCellViewModel(crew: crew)
        }
    }
    
    func headerModel(for index: Int) -> CollapsibleHeaderViewModel {
        let section = sections[index]
        return CollapsibleHeaderViewModel(opened: section.opened,
                                          section: index,
                                          title: section.type.title)
    }
    
    func toggleSection(_ section: Int) {
        sections[section].opened.toggle()
        didToggleSection.value = section
    }
    
    // MARK: - Networking
    
    func getMovieCredits(showLoader: Bool = false) {
        startLoading.value = showLoader
        movieUseCase.getMovieCredits(for: movieId, page: nil, completion: { result in
            switch result {
            case .success(let movieCredits):
                self.processCreditResult(movieCredits)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        })
    }
    
    private func processCreditResult(_ movieCredits: MovieCredits) {
        startLoading.value = false
        let fetchedCast = movieCredits.cast
        let fetchedCrew = movieCredits.crew
        if fetchedCast.isEmpty && fetchedCrew.isEmpty {
            viewState.value = .empty
        } else {
            viewState.value = .populated(fetchedCast, fetchedCrew)
        }
    }
    
}
