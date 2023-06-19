//
//  AuthenticationMockFactory.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 17/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

@testable import UpcomingMovies
@testable import UpcomingMoviesDomain

final class MockAuthPermissionViewModel: AuthPermissionViewModelProtocol {

    var authPermissionURLRequest: URLRequest?

}

final class MockAuthPermissionCoordinator: AuthPermissionCoordinatorProtocol {

    var shouldBeAutomaticallyFinished: Bool = false

    var dismissResult: Void?
    private(set) var dismissCallCount = 0
    func dismiss(completion: (() -> Void)?) {
        if let dismissResult {
            completion?()
        }
        dismissCallCount += 1
    }

    private(set) var didDismissCallCount = 0
    func didDismiss() {
        didDismissCallCount += 1
    }

    var childCoordinators: [Coordinator] = []

    var parentCoordinator: Coordinator?

    var navigationController: UINavigationController = UINavigationController()

    private(set) var startCallCount = 0
    func start() {
        startCallCount += 1
    }

}

final class MockAuthPermissionViewControllerDelegate: AuthPermissionViewControllerDelegate {

    private(set) var didReceiveAuthorizationCallCount = 0
    func authPermissionViewController(_ authPermissionViewController: AuthPermissionViewController, didReceiveAuthorization authorized: Bool) {
        didReceiveAuthorizationCallCount += 1
    }

}

final class MockSignInViewControllerDelegate: MockViewController, SignInViewControllerDelegate {

    private(set) var didTapSignInButtonCallCount = 0
    func signInViewController(_ signInViewController: SignInViewController, didTapSignInButton tapped: Bool) {
        didTapSignInButtonCallCount += 1
    }

}
