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
            switch result {
            case .success(let lists):
                let currentPage = self.viewState.value.currentPage
                self.viewState.value = self.processResult(lists,
                                                          currentPage: currentPage,
                                                          currentLists: self.lists)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        })
    }
    
    private func processResult(_ lists: [List], currentPage: Int,
                               currentLists: [List]) -> SimpleViewState<List> {
        var allLists = currentPage == 1 ? [] : currentLists
        allLists.append(contentsOf: lists)
        guard !allLists.isEmpty else { return .empty }
        
        return lists.isEmpty ? .populated(allLists) : .paging(allLists, next: currentPage + 1)
    }
    
}
