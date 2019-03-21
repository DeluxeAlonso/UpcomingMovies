//
//  AuthPermissionViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit
import WebKit

class AuthPermissionViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var viewModel: AuthPermissionViewModel? {
        didSet {
            setupBindables()
        }
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.allowsBackForwardNavigationGestures = true
    }
    
    // MARK: - Private
    
    private func loardURL() {
        guard let url = viewModel?.authPermissionURL else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        loardURL()
    }

}
