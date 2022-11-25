//
//  AccountViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class AccountViewModel: AccountViewModelProtocol {

    private let interactor: AccountInteractorProtocol

    let showAuthPermission: AnyPublishBindable<URL> = PublishBindable<URL>().asAnyPublishBindable()
    let didSignIn: AnyPublishBindable<Void> = PublishBindable<Void>().asAnyPublishBindable()
    let didReceiveError: AnyPublishBindable<Void> = PublishBindable<Void>().asAnyPublishBindable()

    // MARK: - Initializers

    init(interactor: AccountInteractorProtocol) {
        self.interactor = interactor
    }

    // MARK: - AccountViewModelProtocol

    func startAuthorizationProcess() {
        interactor.getAuthPermissionURL { result in
            switch result {
            case .success(let url):
                self.showAuthPermission.send(url)
            case .failure:
                self.didReceiveError.send()
            }
        }
    }

    func signInUser() {
        interactor.signInUser { result in
            switch result {
            case .success:
                self.didSignIn.send()
            case .failure:
                self.didReceiveError.send()
            }
        }
    }

    func signOutCurrentUser() {
        interactor.signOutUser()
    }

    func isUserSignedIn() -> Bool {
        return currentUser() != nil
    }

    func currentUser() -> User? {
        return interactor.currentUser()
    }

}
