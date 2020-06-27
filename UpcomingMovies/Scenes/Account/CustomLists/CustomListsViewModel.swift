//
//  CustomListsViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/19/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class CustomListsViewModel {
    
    private let useCaseProvider: UseCaseProviderProtocol
    private let accountUseCase: AccountUseCaseProtocol
    
    private let groupOption: ProfileGroupOption
    
    let title: String?
    
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
    
    init(useCaseProvider: UseCaseProviderProtocol, groupOption: ProfileGroupOption) {
        self.useCaseProvider = useCaseProvider
        self.accountUseCase = self.useCaseProvider.accountUseCase()
        
        self.groupOption = groupOption
        self.title = groupOption.title
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
        switch groupOption {
        case .customLists:
            accountUseCase.getCustomLists(page: currentPage, completion: { result in
                self.startLoading.value = false
                switch result {
                case .success(let lists):
                    self.processListResult(lists, currentPage: currentPage)
                case .failure(let error):
                    self.viewState.value = .error(error)
                }
            })
        }
    }
    
    private func processListResult(_ lists: [List], currentPage: Int) {
        var allLists = currentPage == 1 ? [] : viewState.value.currentEntities
        allLists.append(contentsOf: lists)
        guard !allLists.isEmpty else {
            viewState.value = .empty
            return
        }
        if lists.isEmpty {
            viewState.value = .populated(allLists)
        } else {
            viewState.value = .paging(allLists, next: currentPage + 1)
        }
    }
    
}
