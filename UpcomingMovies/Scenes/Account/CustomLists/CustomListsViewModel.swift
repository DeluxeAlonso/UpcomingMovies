//
//  CustomListsViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/19/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class CustomListsViewModel: CustomListsViewModelProtocol {

    // MARK: - Dependencies
    
    private let interactor: CustomListsInteractorProtocol
    private let viewStateHandler: ViewStateHandlerProtocol
    
    // MARK: - Reactive properties
    
    private (set) var startLoading: Bindable<Bool> = Bindable(false)
    private (set) var viewState: Bindable<SimpleViewState<List>> = Bindable(.initial)
    
    // MARK: - Computed properties
    
    var lists: [List] {
        return viewState.value.currentEntities
    }
    
    var listCells: [CustomListCellViewModelProtocol] {
        return lists.map { CustomListCellViewModel($0) }
    }
    
    // MARK: - Initializers
    
    init(interactor: CustomListsInteractorProtocol, viewStateHandler: ViewStateHandlerProtocol) {
        self.interactor = interactor
        self.viewStateHandler = viewStateHandler
    }
    
    // MARK: - CustomListsViewModelProtocol
    
    func list(at index: Int) -> List {
        return lists[index]
    }
    
    func getCustomLists() {
        let showLoader = viewState.value.isInitialPage
        fetchCustomLists(currentPage: viewState.value.currentPage, showLoader: showLoader)
    }
    
    func refreshCustomLists() {
        fetchCustomLists(currentPage: 1, showLoader: false)
    }

    // MARK: - Private
    
    private func fetchCustomLists(currentPage: Int, showLoader: Bool) {
        startLoading.value = showLoader
        interactor.getCustomLists(page: currentPage, completion: { result in
            self.startLoading.value = false
            switch result {
            case .success(let lists):
                let currentPage = self.viewState.value.currentPage
                self.viewState.value = self.viewStateHandler.processResult(lists,
                                                                           currentPage: currentPage,
                                                                           currentEntities: self.lists)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        })
    }
    
}
