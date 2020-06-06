//
//  SignInViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

protocol SignInViewControllerDelegate: class {
    
    func signInViewController(_ signInViewController: SignInViewController, didTapSignInButton tapped: Bool)
    
}

class SignInViewController: UIViewController {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var signInButton: ShrinkingButton!
    
    weak var delegate: SignInViewControllerDelegate?
    
    /// Images we are going to display animated  above the sign in button.
    private let transitionImages: [UIImage] = [#imageLiteral(resourceName: "SignInLogoFirst"), #imageLiteral(resourceName: "SignInLogoSecond"), #imageLiteral(resourceName: "SignInLogoThird")]
    private var currentSliderImageIndex = 1
    weak var sliderTimer: Timer?
    
    // MARK: - Lifecycle
    
    deinit {
        sliderTimer?.invalidate()
        sliderTimer = nil
    }
    
    override func viewDidLoad() {
        setupSliderTimer()
    }
    
    // MARK: - Private
    
    private func setupSliderTimer() {
        sliderTimer = Timer.scheduledTimer(timeInterval: 2.0,
                                           target: self,
                                           selector: #selector(startSliderIconTransition),
                                           userInfo: nil, repeats: true)
    }
    
    @objc private func startSliderIconTransition() {
        let image = transitionImages[currentSliderImageIndex]
        updateSliderimageIndex()
        UIView.transition(with: self.iconImageView,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
          self.iconImageView.image = image
        }, completion: nil)
    }
    
    private func updateSliderimageIndex() {
      if (currentSliderImageIndex == transitionImages.count - 1) {
        currentSliderImageIndex = 0
      } else {
        currentSliderImageIndex += 1
      }
    }
    
    // MARK: - Public
    
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
