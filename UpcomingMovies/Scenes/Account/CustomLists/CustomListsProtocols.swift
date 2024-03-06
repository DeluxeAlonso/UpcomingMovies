//
//  CustomListsProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

protocol CustomListsViewModelProtocol {

    var startLoading: AnyBehaviorBindable<Bool> { get }
    var viewState: AnyBehaviorBindable<CustomListsViewState> { get }
    var listCells: [CustomListCellViewModelProtocol] { get }

    func list(at index: Int) -> List

    func getCustomLists()
    func refreshCustomLists()

}

protocol CustomListsInteractorProtocol {

    func getCustomLists(page: Int?, completion: @escaping (Result<[List], Error>) -> Void)

}

protocol CustomListsCoordinatorProtocol: Coordinator {

    func showListDetail(for customList: List)

}
