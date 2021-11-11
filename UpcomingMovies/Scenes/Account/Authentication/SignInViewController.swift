//
//  SignInViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

protocol SignInViewControllerDelegate: UIViewController {

    func signInViewController(_ signInViewController: SignInViewController, didTapSignInButton tapped: Bool)

}

class SignInViewController: UIViewController, Storyboarded {

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var signInButton: ShrinkingButton!

    static var storyboardName: String = "Account"

    weak var delegate: SignInViewControllerDelegate?

    /// Images we are going to display animated  above the sign in button.
    private let transitionImages: [UIImage] = [#imageLiteral(resourceName: "SignInLogoFirst"), #imageLiteral(resourceName: "SignInLogoSecond"), #imageLiteral(resourceName: "SignInLogoThird")]
    private var imageTransitionHandler: ImageTransitionHandler!

    // MARK: - Lifecycle

    deinit {
        imageTransitionHandler.invalidate()
    }

    override func viewDidLoad() {
        setupImageTransionHandler()
    }

    // MARK: - Private

    private func setupImageTransionHandler() {
        imageTransitionHandler = ImageTransitionHandler(imageView: iconImageView,
                                                        transitionImages: transitionImages)
    }

    // MARK: - Internal

    func startLoading() {
        signInButton.startAnimation()
    }

    func stopLoading() {
        signInButton.stopAnimation(revertAfterDelay: 0.1, completion: nil)
    }

    // MARK: - Actions

    @IBAction func loginButtonAction(_ sender: Any) {
        delegate?.signInViewController(self, didTapSignInButton: true)
    }

}
