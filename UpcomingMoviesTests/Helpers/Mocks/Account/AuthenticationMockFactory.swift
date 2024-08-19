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
        if dismissResult != nil {
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

    private(set) var startWithCoordinatorModeCallCount = 0
    func start(coordinatorMode: CoordinatorMode) {
        startWithCoordinatorModeCallCount += 1
    }

}

final class MockAuthPermissionViewControllerDelegate: AuthPermissionViewControllerDelegate {

    private(set) var didReceiveAuthorizationCallCount = 0
    func authPermissionViewController(_ authPermissionViewController: AuthPermissionViewController, didReceiveAuthorization authorized: Bool) {
        didReceiveAuthorizationCallCount += 1
    }

}

final class MockSignInViewControllerDelegate: MockViewController, SignInViewControllerDelegate {

    private(set) var didUpdateAuthenticationStateCallCount = 0
    func didUpdateAuthenticationState(_ state: AuthenticationState) {
        didUpdateAuthenticationStateCallCount += 1
    }

}

final class MockSignInInteractor: SignInInteractorProtocol {

    var permissionURLResult: Result<URL, Error>?
    func getAuthPermissionURL(completion: @escaping (Result<URL, Error>) -> Void) {
        if let permissionURLResult {
            completion(permissionURLResult)
        }
    }

    var signInUserResult: Result<User, Error>?
    func signInUser(completion: @escaping (Result<User, Error>) -> Void) {
        if let signInUserResult {
            completion(signInUserResult)
        }
    }

}

final class MockSignInViewModel: SignInViewModelProtocol {

    var startLoading: AnyBehaviorBindable<Bool> = BehaviorBindable(false).eraseToAnyBindable()
    var showAuthPermission: AnyPublishBindable<URL> = PublishBindable<URL>().eraseToAnyBindable()
    var didUpdateAuthenticationState = BehaviorBindable<AuthenticationState?>(nil).eraseToAnyBindable()
    var didReceiveError: AnyPublishBindable<Void> = PublishBindable<Void>().eraseToAnyBindable()

    var signInButtonTitle: String? = ""

    private(set) var startAuthorizationProcessCallCount = 0
    func startAuthorizationProcess() {
        startAuthorizationProcessCallCount += 1
    }

    private(set) var signInUserCallCount = 0
    func signInUser() {
        signInUserCallCount += 1
    }

}

final class MockSignInCoordinator: SignInCoordinatorProtocol {

    private(set) var showAuthPermissionCallCount = 0
    func showAuthPermission(for authPermissionURL: URL, and authPermissionDelegate: AuthPermissionViewControllerDelegate) {
        showAuthPermissionCallCount += 1
    }

}
