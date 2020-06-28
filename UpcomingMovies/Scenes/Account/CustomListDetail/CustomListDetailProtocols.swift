//
//  CustomListDetailProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

protocol CustomListDetailViewModelProtocol {
 
    var name: String { get }
    
    var viewState: Bindable<CustomListDetailViewState> { get }
    
    var movieCells: [MovieCellViewModel] { get }
    
    func buildHeaderViewModel() -> CustomListDetailHeaderViewModel
    func buildSectionViewModel() -> CustomListDetailSectionViewModel
    
    func movie(at index: Int) -> Movie
    
    func getListMovies()
    
}

protocol CustomListDetailCoordinatorProtocol: class {
    
    func showMovieDetail(for movie: Movie)
    
}
