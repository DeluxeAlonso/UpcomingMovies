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
    let movieTitle: String
    
    private let interactor: MovieCreditsInteractorProtocol
    private var factory: MovieCreditsFactoryProtocol
    
    var viewState: Bindable<MovieCreditsViewState> = Bindable(.initial)
    var didToggleSection: Bindable<Int> = Bindable(0)
    var startLoading: Bindable<Bool> = Bindable(false)
    
    // MARK: - Initializers
    
    init(movieId: Int, movieTitle: String,
         interactor: MovieCreditsInteractorProtocol,
         factory: MovieCreditsFactoryProtocol) {
        self.movieId = movieId
        self.movieTitle = movieTitle

        self.interactor = interactor
        self.factory = factory
    }
    
    // MARK: - Public
    
    func numberOfSections() -> Int {
        return factory.sections.count
    }
    
    func numberOfItems(for section: Int) -> Int {
        let section = factory.sections[section]
        guard section.opened else { return 0 }
        switch section.type {
        case .cast:
            return viewState.value.currentCast.count
        case .crew:
            return viewState.value.currentCrew.count
        }
    }
    
    func creditModel(for section: Int, and index: Int) -> MovieCreditCellViewModelProtocol {
        switch factory.sections[section].type {
        case .cast:
            let cast = viewState.value.currentCast[index]
            return MovieCreditCellViewModel(cast: cast)
        case .crew:
            let crew = viewState.value.currentCrew[index]
            return MovieCreditCellViewModel(crew: crew)
        }
    }
    
    func headerModel(for index: Int) -> CollapsibleHeaderViewModel {
        let section = factory.sections[index]
        return CollapsibleHeaderViewModel(opened: section.opened,
                                          section: index,
                                          title: section.type.title)
    }
    
    func toggleSection(_ section: Int) {
        factory.sections[section].opened.toggle()
        didToggleSection.value = section
    }
    
    // MARK: - Networking
    
    func getMovieCredits(showLoader: Bool = false) {
        startLoading.value = showLoader
        interactor.getMovieCredits(for: movieId, page: nil, completion: { result in
            self.startLoading.value = false
            switch result {
            case .success(let movieCredits):
                self.viewState.value = self.processResult(movieCredits)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        })
    }
    
    private func processResult(_ movieCredits: MovieCredits) -> MovieCreditsViewState {
        let fetchedCast = movieCredits.cast
        let fetchedCrew = movieCredits.crew
        if fetchedCast.isEmpty && fetchedCrew.isEmpty {
           return .empty
        } else {
            return .populated(fetchedCast, fetchedCrew)
        }
    }
    
}
