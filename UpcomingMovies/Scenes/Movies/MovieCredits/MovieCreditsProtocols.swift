//
//  MovieCreditsProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

protocol MovieCreditsViewModelProtocol {
    
    var movieTitle: String { get set }
    
    var viewState: Bindable<MovieCreditsViewState> { get }
    var startLoading: Bindable<Bool> { get }
    
    var castCells: [MovieCreditCellViewModel] { get }
    var crewCells: [MovieCreditCellViewModel] { get }
 
    func numberOfSections() -> Int
    func rowCount(for section: Int) -> Int
    
    func credit(for section: Int, and index: Int) -> MovieCreditCellViewModel
    func headerModel(for index: Int) -> CollapsibleHeaderViewModel
    
    @discardableResult
    func toggleSection(_ section: Int) -> Bool

    func getMovieCredits(showLoader: Bool)
    
}

protocol MovieCreditsCoordinatorProtocol: class {}
