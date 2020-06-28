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
    
    private let movieId: Int
    var movieTitle: String
    
    private let useCaseProvider: UseCaseProviderProtocol
    private let movieUseCase: MovieUseCaseProtocol
    
    private var sections = [MovieCreditsCollapsibleSection(type: .cast,
                                                           opened: true),
                            MovieCreditsCollapsibleSection(type: .crew, opened: false)]
    
    var viewState: Bindable<MovieCreditsViewState> = Bindable(.initial)
    var startLoading: Bindable<Bool> = Bindable(false)
    
    var castCells: [MovieCreditCellViewModel] {
        return viewState.value.currentCast.map { MovieCreditCellViewModel(cast: $0) }
    }
    
    var crewCells: [MovieCreditCellViewModel] {
        return viewState.value.currentCrew.map { MovieCreditCellViewModel(crew: $0) }
    }
    
    // MARK: - Initializers
    
    init(movieId: Int, movieTitle: String, useCaseProvider: UseCaseProviderProtocol) {
        self.movieId = movieId
        self.movieTitle = movieTitle
        
        self.useCaseProvider = useCaseProvider
        self.movieUseCase = self.useCaseProvider.movieUseCase()
    }
    
    // MARK: - Public
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func rowCount(for section: Int) -> Int {
        let section = sections[section]
        guard section.opened else { return 0 }
        switch section.type {
        case .cast:
            return castCells.count
        case .crew:
            return crewCells.count
        }
    }
    
    func credit(for section: Int, and index: Int) -> MovieCreditCellViewModel {
        switch sections[section].type {
        case .cast:
            return castCells[index]
        case .crew:
            return crewCells[index]
        }
    }
    
    func headerModel(for index: Int) -> CollapsibleHeaderViewModel {
        let section = sections[index]
        return CollapsibleHeaderViewModel(opened: section.opened,
                                          section: index,
                                          title: section.type.title)
    }
    
    @discardableResult
    func toggleSection(_ section: Int) -> Bool {
        sections[section].opened = !sections[section].opened
        return sections[section].opened
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

// MARK: - View sections

extension MovieCreditsViewModel {
    
    struct MovieCreditsCollapsibleSection {
        let type: MovieCreditsViewSection
        var opened: Bool
    }
    
    enum MovieCreditsViewSection {
        case cast, crew
        
        var title: String {
            switch self {
            case .cast:
                return "Cast"
            case .crew:
                return "Crew"
            }
        }
        
    }
    
}
