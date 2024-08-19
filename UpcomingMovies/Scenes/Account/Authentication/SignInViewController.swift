//
//  SignInViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

final class SignInViewController: UIViewController, Storyboarded {

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var signInButton: ShrinkingButton!

    static var storyboardName: String = "Account"

    var viewModel: SignInViewModelProtocol?
    weak var coordinator: SignInCoordinatorProtocol?
    weak var delegate: SignInViewControllerDelegate?

    /// Images we are going to display animated  above the sign in button.
    private let transitionImages: [UIImage] = [#imageLiteral(resourceName: "SignInLogoFirst"), #imageLiteral(resourceName: "SignInLogoSecond"), #imageLiteral(resourceName: "SignInLogoThird")]
    private var imageTransitionHandler: ImageTransitionHandlerProtocol?

    // MARK: - Lifecycle

    deinit {
        imageTransitionHandler?.invalidate()
    }

    override func viewDidLoad() {
        setupUI()
        setupBindables()
    }

    // MARK: - Private

    private func setupUI() {
        signInButton.setTitle(viewModel?.signInButtonTitle, for: .normal)
        setupImageTransionHandler()
    }

    private func setupImageTransionHandler() {
        imageTransitionHandler = ImageTransitionHandler(imageView: iconImageView,
                                                        transitionImages: transitionImages)
    }

    private func setupBindables() {
        viewModel?.startLoading.bind({ [weak self] start in
            guard let self else { return }
            start ? self.startLoading() : self.stopLoading()
        }, on: .main)
        viewModel?.didUpdateAuthenticationState.bindAndFire({ [weak self] authState in
            guard let self = self, let authState else { return }
            self.delegate?.didUpdateAuthenticationState(authState)
        }, on: .main)
        viewModel?.showAuthPermission.bind({ [weak self] authPermissionURL in
            guard let self else { return }
            self.coordinator?.showAuthPermission(for: authPermissionURL, and: self)
        }, on: .main)
        viewModel?.didReceiveError.bind({ [weak self] in
            guard let self = self else { return }
            self.stopLoading()
        }, on: .main)
    }

    private func startLoading() {
        signInButton.startAnimation()
    }

    private func stopLoading() {
        signInButton.stopAnimation(revertAfterDelay: 0.1, completion: nil)
    }

    // MARK: - Actions

    @IBAction func loginButtonAction(_ sender: Any) {
        viewModel?.startAuthorizationProcess()
    }

}

// MARK: - AuthPermissionViewControllerDelegate

extension SignInViewController: AuthPermissionViewControllerDelegate {

    func authPermissionViewController(_ authPermissionViewController: AuthPermissionViewController,
                                      didReceiveAuthorization authorized: Bool) {
        if authorized { viewModel?.signInUser() }
    }

}
