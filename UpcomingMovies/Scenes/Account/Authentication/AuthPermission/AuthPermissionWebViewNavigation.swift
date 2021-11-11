//
//  AuthPermissionWebViewNavigation.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/13/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import WebKit

class AuthPermissionWebViewNavigation: NSObject, AuthPermissionWebViewNavigationDelegate {

    var didFinishNavigation: () -> Void

    // MARK: - Initializers

    init(didFinishNavigation: @escaping () -> Void) {
        self.didFinishNavigation = didFinishNavigation
    }

    // MARK: - WKNavigationDelegate

    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        didFinishNavigation()
    }

}
