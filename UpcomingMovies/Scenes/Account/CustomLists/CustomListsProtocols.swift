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
    
    var title: String? { get set }
    
    var startLoading: Bindable<Bool> { get set }
    var viewState: Bindable<SimpleViewState<List>> { get set }
    
    var lists: [List] { get }
    var listCells: [CustomListCellViewModel] { get }
    
    func list(at index: Int) -> List
    
    func getCustomLists()
    func refreshCustomLists()
    
}

protocol CustomListsCoordinatorProtocol: class {
 
    func showDetail(for customList: List)
    
}
