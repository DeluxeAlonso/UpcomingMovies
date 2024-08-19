//
//  SignInViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/07/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import Foundation

final class SignInViewModel: SignInViewModelProtocol {

    private let interactor: SignInInteractorProtocol

    let startLoading = BehaviorBindable(false).eraseToAnyBindable()
    let showAuthPermission = PublishBindable<URL>().eraseToAnyBindable()
    let didUpdateAuthenticationState = BehaviorBindable<AuthenticationState?>(nil).eraseToAnyBindable()
    let didReceiveError = PublishBindable<Void>().eraseToAnyBindable()

    var signInButtonTitle: String? {
        LocalizedStrings.signIn()
    }

    init(interactor: SignInInteractorProtocol) {
        self.interactor = interactor
    }

    // MARK: - SignInViewModelProtocol

    func startAuthorizationProcess() {
        startLoading.value = true
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

}
