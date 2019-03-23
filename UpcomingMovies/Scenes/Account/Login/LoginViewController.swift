//
//  LoginViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate: class {
    
    func loginViewController(_ loginViewController: LoginViewController, didTapLoginButton tapped: Bool)
    
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var signInButton: UIButton!
    
    weak var delegate: LoginViewControllerDelegate?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        setupButtons()
    }
    
    private func setupButtons() {
        signInButton.layer.cornerRadius = 5
    }
    
    // MARK: - Actions

    @IBAction func loginButtonAction(_ sender: Any) {
        delegate?.loginViewController(self, didTapLoginButton: true)
    }
    
}
