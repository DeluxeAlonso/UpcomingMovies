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
    
    weak var delegate: LoginViewControllerDelegate?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions

    @IBAction func loginButtonAction(_ sender: Any) {
        delegate?.loginViewController(self, didTapLoginButton: true)
    }
    
}
