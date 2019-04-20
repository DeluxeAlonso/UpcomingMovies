//
//  ProfileCreatedListsViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/19/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import CoreData

final class ProfileCreatedListsViewModel {
    
    private let managedObjectContext: NSManagedObjectContext
    private let groupOption: ProfileGroupOption
    
    private let accountClient = AccountClient()
    
    private let userCredentials = AuthenticationManager.shared.userCredentials()
    
    let title: String?
    
    // MARK: - Reactive properties
    
    var startLoading: ((Bool) -> Void)?
    var viewState: Bindable<SimpleViewState<List>> = Bindable(.initial)
    
    // MARK: - Computed properties
    
    var lists: [List] {
        return viewState.value.currentEntities
    }
    
    var listCells: [CreatedListCellViewModel] {
        return lists.map { CreatedListCellViewModel($0) }
    }
    
    // MARK: - Initializers
    
    init(_ managedObjectContext: NSManagedObjectContext, groupOption: ProfileGroupOption) {
        self.managedObjectContext = managedObjectContext
        self.groupOption = groupOption
        self.title = groupOption.title
    }
    
    // MARK: - Networking
    
    func getCreatedLists() {
        guard let credentials = userCredentials else { fatalError() }
        startLoading?(true)
        accountClient.getCreatedLists(page: viewState.value.currentPage,
                                      groupOption: groupOption,
                                      sessionId: credentials.sessionId,
                                      accountId: credentials.accountId) { result in
            switch result {
            case .success(let listResult):
                guard let listResult = listResult else { return }
                self.processListResult(listResult)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        }
    }
    
    private func processListResult(_ listResult: ListResult) {
        startLoading?(false)
        var allLists = listResult.currentPage == 1 ? [] : viewState.value.currentEntities
        allLists.append(contentsOf: listResult.results)
        guard !allLists.isEmpty else {
            viewState.value = .empty
            return
        }
        if listResult.hasMorePages {
            viewState.value = .paging(allLists, next: listResult.nextPage)
        } else {
            viewState.value = .populated(allLists)
        }
    }
    
}
