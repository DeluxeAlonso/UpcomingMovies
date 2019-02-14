//
//  MovieCreditsViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/13/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class MovieCreditsViewModel {
    
    private let movieId: Int
    let movieTitle: String
    
    private let movieClient = MovieClient()
    private var sections: [MovieCreditsViewSections] = [.cast, .crew]
    
    var viewState: Bindable<ViewState> = Bindable(.loading)
    
    var castCells: [MovieCreditCellViewModel] {
        return viewState.value.currentCast.map { MovieCreditCellViewModel(cast: $0) }
    }
    
    var crewCells: [MovieCreditCellViewModel] {
        return viewState.value.currentCrew.map { MovieCreditCellViewModel(crew: $0) }
    }
    
    // MARK: - Initializers
    
    init(movieId: Int, movieTitle: String) {
        self.movieId = movieId
        self.movieTitle = movieTitle
    }
    
    // MARK: - Networking
    
    func getMovieCredits() {
        movieClient.getMovieCredits(with: movieId) { result in
            switch result {
            case .success(let creditResult):
                guard let creditResult = creditResult else { return }
                self.processCreditResult(creditResult)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        }
    }
    
    private func processCreditResult(_ creditResult: CreditResult) {
        let fetchedCast = creditResult.cast
        let fetchedCrew = creditResult.crew
        if fetchedCast.isEmpty && fetchedCrew.isEmpty {
            viewState.value = .empty
        } else {
            viewState.value = .populated(fetchedCast, fetchedCrew)
        }
    }
    
}

// MARK: - View sections

extension MovieCreditsViewModel {
    
    enum MovieCreditsViewSections {
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

// MARK: - View states

extension MovieCreditsViewModel {
    
    enum ViewState {
        case loading
        case empty
        case populated([Cast], [Crew])
        case error(Error)
        
        var currentCast: [Cast] {
            switch self {
            case .populated(let cast, _):
                return cast
            case .loading, .empty, .error:
                return []
            }
        }
        
        var currentCrew: [Crew] {
            switch self {
            case .populated(_, let crew):
                return crew
            case .loading, .empty, .error:
                return []
            }
        }
        
    }
    
}
