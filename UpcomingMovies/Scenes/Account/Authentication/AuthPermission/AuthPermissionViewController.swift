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
                                      didReceiveAuthorization authorized: Bool)
    
}

class AuthPermissionViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    
    static var storyboardName = "Account"
    
    private var webViewNavigationDelegate: AuthPermissionWebViewNavigationDelegate!
    
    var viewModel: AuthPermissionViewModelProtocol?
    weak var coordinator: AuthPermissionCoordinatorProtocol?
    weak var delegate: AuthPermissionViewControllerDelegate?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindables()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        setupNavigationBar()
        setupWebView()
    }
    
    private func setupNavigationBar() {
        navigationController?.presentationController?.delegate = self
        
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
        
        webViewNavigationDelegate = AuthPermissionWebViewNavigation(didValidateCallback: didValidateCallback,
                                                                   didFinishNavigation: didFinishNavigation)
        webView.navigationDelegate = webViewNavigationDelegate
        webView.allowsBackForwardNavigationGestures = true
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        loadURL()
    }
    
    private func loadURL() {
        guard let urlRequest = viewModel?.authPermissionURLRequest else { return }
        webView.load(urlRequest)
    }
    
    private func dismiss() {
        coordinator?.dismiss(completion: {
            self.delegate?.authPermissionViewController(self, didReceiveAuthorization: true)
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
        coordinator?.didDismiss()
        delegate?.authPermissionViewController(self, didReceiveAuthorization: true)
    }
    
}
