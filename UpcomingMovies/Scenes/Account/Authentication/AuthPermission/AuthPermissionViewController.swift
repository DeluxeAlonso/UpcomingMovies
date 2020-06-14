//
//  AuthPermissionViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit
import WebKit

protocol AuthPermissionViewControllerDelegate: class {
    
    func authPermissionViewController(_ authPermissionViewController: AuthPermissionViewController,
                                      didSignedIn signedIn: Bool)
    
}

class AuthPermissionViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    
    private var webKitNavigationDelegate: AuthPermissionWebKitNavigationDelegate!
    
    weak var delegate: AuthPermissionViewControllerDelegate?
    
    var viewModel: AuthPermissionViewModel? {
        didSet {
            setupBindables()
        }
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.presentationController?.delegate = self
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        setupNavigationBar()
        setupWebView()
    }
    
    private func setupNavigationBar() {
        let closeBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop,
                                                 target: self, action: #selector(closeBarButtonAction))
        navigationItem.leftBarButtonItem = closeBarButtonItem
    }
    
    private func setupWebView() {
        let didValidateCallback = { [unowned self] in
            self.dismiss()
        }
        
        let didFinishNavigation = { [unowned self] in
            self.checkNavigationButtonsState()
        }
        
        webKitNavigationDelegate = AuthPermissionWebKitNavigation(didValidateCallback: didValidateCallback,
                                                                  didFinishNavigation: didFinishNavigation)
        webView.navigationDelegate = webKitNavigationDelegate
        webView.allowsBackForwardNavigationGestures = true
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        loadURL()
    }
    
    private func loadURL() {
        guard let url = viewModel?.authPermissionURL else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    private func dismiss() {
        dismiss(animated: true, completion: {
            self.delegate?.authPermissionViewController(self, didSignedIn: true)
        })
    }
    
    private func checkNavigationButtonsState() {
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
    
    // MARK: - Selectors
    
    @objc func closeBarButtonAction() {
        dismiss()
    }
    
    // MARK: - Actions
    
    @IBAction func backButtonAction(_ sender: Any) {
        webView.goBack()
    }
    
    @IBAction func forwardButtonAction(_ sender: Any) {
        webView.goForward()
    }
    
    @IBAction func reloadButtonAction(_ sender: Any) {
        loadURL()
    }
    
}

// MARK: - UIAdaptivePresentationControllerDelegate

extension AuthPermissionViewController: UIAdaptivePresentationControllerDelegate {
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        delegate?.authPermissionViewController(self, didSignedIn: true)
    }
    
}
