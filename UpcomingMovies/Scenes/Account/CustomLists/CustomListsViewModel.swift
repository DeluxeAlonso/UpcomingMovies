//
//  CustomListsViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/19/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class CustomListsViewModel: CustomListsViewModelProtocol, SimpleViewStateProcessable {

    // MARK: - Dependencies

    private let interactor: CustomListsInteractorProtocol

    // MARK: - Reactive properties

    let startLoading = BehaviorBindable(false).eraseToAnyBindable()
    let viewState = BehaviorBindable(CustomListsViewState.initial).eraseToAnyBindable()

    // MARK: - Computed properties

    var title: String? {
        LocalizedStrings.customListGroupOption()
    }

    private var lists: [ListProtocol] {
        viewState.value.currentEntities
    }

    var listCells: [CustomListCellViewModelProtocol] {
        lists.map { CustomListCellViewModel($0) }
    }

    // MARK: - Initializers

    init(interactor: CustomListsInteractorProtocol) {
        self.interactor = interactor
    }

    // MARK: - CustomListsViewModelProtocol

    func list(at index: Int) -> ListProtocol {
        lists[index]
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
                self.viewState.value = self.processResult(lists,
                                                          currentPage: currentPage,
                                                          currentEntities: self.lists)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        })
    }

}
