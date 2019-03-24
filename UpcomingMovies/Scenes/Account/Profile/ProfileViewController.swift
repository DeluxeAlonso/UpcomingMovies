//
//  ProfileViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

protocol ProfileViewControllerDelegate: class {

    func profileViewController(_ profileViewController: ProfileViewController, didTapSignOutButton tapped: Bool)
    
}

class ProfileViewController: UIViewController {
    
    weak var delegate: ProfileViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signOutButtonAction(_ sender: Any) {
       delegate?.profileViewController(self, didTapSignOutButton: true)
    }

}
