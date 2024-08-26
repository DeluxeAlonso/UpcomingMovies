//
//  CustomListDetailProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

protocol CustomListDetailViewModelProtocol {

    var listName: String? { get }
    var viewState: AnyBehaviorBindable<CustomListDetailViewState> { get }
    var movieCells: [MovieListCellViewModel] { get }

    var emptyMovieResultsTitle: String { get }

    func buildHeaderViewModel() -> CustomListDetailHeaderViewModelProtocol
    func buildSectionViewModel() -> CustomListDetailSectionViewModel

    func movie(at index: Int) -> MovieProtocol

    func getListMovies()

}

protocol CustomListDetailInteractorProtocol {

    func getCustomListMovies(listId: String, completion: @escaping (Result<[MovieProtocol], Error>) -> Void)

}

protocol CustomListDetailCoordinatorProtocol: AnyObject, MovieDetailCoordinable {}
