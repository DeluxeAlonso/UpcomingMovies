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

    let showAuthPermission = PublishBindable<URL>().eraseToAnyBindable()
    let didUpdateAuthenticationState = BehaviorBindable<AuthenticationState?>(nil).eraseToAnyBindable()
    let didReceiveError = PublishBindable<Void>().eraseToAnyBindable()

    // MARK: - Initializers

    init(interactor: AccountInteractorProtocol) {
        self.interactor = interactor

        didUpdateAuthenticationState.value = isUserSignedIn() ? .currentlySignedIn : .currentlySignedOut
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
                self.didUpdateAuthenticationState.value = .justSignedIn
            case .failure:
                self.didReceiveError.send()
            }
        }
    }

    func signOutCurrentUser() {
        interactor.signOutUser { result in
            switch result {
            case .success:
                self.didUpdateAuthenticationState.value = .justSignedOut
            case .failure:
                self.didReceiveError.send()
            }
        }
    }

    func isUserSignedIn() -> Bool {
        currentUser() != nil
    }

    func currentUser() -> User? {
        interactor.currentUser()
    }

}

// MARK: - Authentication State

enum AuthenticationState {
    case currentlySignedIn, justSignedIn
    case currentlySignedOut, justSignedOut
}
