//
//  AuthPermissionViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit
import WebKit

protocol AuthPermissionViewControllerDelegate: AnyObject {

    func authPermissionViewController(_ authPermissionViewController: AuthPermissionViewController,
                                      didReceiveAuthorization authorized: Bool)

}

final class AuthPermissionViewController: UIViewController, Storyboarded {

    @IBOutlet private weak var progressView: UIProgressView!
    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var backButton: UIBarButtonItem!
    @IBOutlet private weak var forwardButton: UIBarButtonItem!
    @IBOutlet private weak var reloadButton: UIBarButtonItem!

    static var storyboardName = "Account"

    private var estimatedProgressObserver: NSKeyValueObservation?
    private var webViewNavigationDelegate: AuthPermissionWebViewNavigationDelegate?

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
        let didFinishNavigation = { [unowned self] in
            self.checkNavigationButtonsState()
        }

        let didUpdateProgress: (WKWebView, Any) -> Void = { [unowned self] webView, _ in
            self.updateProgressView(with: webView.estimatedProgress)
        }

        webViewNavigationDelegate = AuthPermissionWebViewNavigation(didFinishNavigation: didFinishNavigation)
        webView.navigationDelegate = webViewNavigationDelegate
        webView.allowsBackForwardNavigationGestures = true
        estimatedProgressObserver = webView.observe(\.estimatedProgress, options: [.new],
                                                    changeHandler: didUpdateProgress)
    }

    // MARK: - Reactive Behavior

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

    private func updateProgressView(with value: Double) {
        progressView.progress = Float(value)

        if value == 1.0 {
            progressView.fadeOut(0.5)
        } else {
            progressView.fadeIn(0.0)
        }
    }

    // MARK: - Selectors

    @objc func closeBarButtonAction() {
        dismiss()
    }

    // MARK: - Actions

    @IBAction private func backButtonAction(_ sender: Any) {
        webView.goBack()
    }

    @IBAction private func forwardButtonAction(_ sender: Any) {
        webView.goForward()
    }

    @IBAction private func reloadButtonAction(_ sender: Any) {
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
