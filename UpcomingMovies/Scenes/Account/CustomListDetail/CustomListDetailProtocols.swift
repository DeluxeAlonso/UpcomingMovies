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

    var listName: String? { get }
    var viewState: Bindable<CustomListDetailViewState> { get }
    var movieCells: [MovieCellViewModel] { get }

    func buildHeaderViewModel() -> CustomListDetailHeaderViewModelProtocol
    func buildSectionViewModel() -> CustomListDetailSectionViewModel

    func movie(at index: Int) -> Movie

    func getListMovies()

}

protocol CustomListDetailInteractorProtocol {

    func getCustomListMovies(listId: String, completion: @escaping (Result<[Movie], Error>) -> Void)

}

protocol CustomListDetailCoordinatorProtocol: AnyObject {

    func showMovieDetail(for movie: Movie)

}
