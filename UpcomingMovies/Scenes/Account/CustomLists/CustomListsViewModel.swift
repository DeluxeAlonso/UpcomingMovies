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
    
    private let interactor: CustomListsInteractorProtocol
    
    // MARK: - Reactive properties
    
    var startLoading: Bindable<Bool> = Bindable(false)
    var viewState: Bindable<SimpleViewState<List>> = Bindable(.initial)
    
    // MARK: - Computed properties
    
    var lists: [List] {
        return viewState.value.currentEntities
    }
    
    var listCells: [CustomListCellViewModel] {
        return lists.map { CustomListCellViewModel($0) }
    }
    
    // MARK: - Initializers
    
    init(interactor: CustomListsInteractorProtocol) {
        self.interactor = interactor
    }
    
    // MARK: - Public
    
    func list(at index: Int) -> List {
        return lists[index]
    }
    
    // MARK: - Networking
    
    func getCustomLists() {
        let showLoader = viewState.value.isInitialPage
        fetchCustomLists(currentPage: viewState.value.currentPage, showLoader: showLoader)
    }
    
    func refreshCustomLists() {
        fetchCustomLists(currentPage: 1, showLoader: false)
    }
    
    private func fetchCustomLists(currentPage: Int, showLoader: Bool) {
        startLoading.value = showLoader
        interactor.getCustomLists(page: currentPage, completion: { result in
            self.startLoading.value = false
            
            let currentPage = self.viewState.value.currentPage
            self.viewState.value = self.processResult(result,
                                                      currentPage: currentPage,
                                                      currentLists: self.lists)
        })
    }
    
    private func processResult(_ result: Result<[List], Error>, currentPage: Int,
                               currentLists: [List]) -> SimpleViewState<List> {
        switch result {
        case .success(let lists):
            return self.viewState(for: lists,
                                  currentPage: currentPage,
                                  currentLists: currentLists)
        case .failure(let error):
            return .error(error)
        }
    }
    
    private func viewState(for lists: [List], currentPage: Int,
                           currentLists: [List]) -> SimpleViewState<List> {
        var allLists = currentPage == 1 ? [] : currentLists
        allLists.append(contentsOf: lists)
        guard !allLists.isEmpty else { return .empty }
        
        return lists.isEmpty ? .populated(allLists) : .paging(allLists, next: currentPage + 1)
    }
    
}
