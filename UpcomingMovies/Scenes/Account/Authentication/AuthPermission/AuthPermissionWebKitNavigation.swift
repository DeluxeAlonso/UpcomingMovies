//
//  AuthPermissionWKNavigation.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/13/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import WebKit

protocol AuthPermissionWebKitNavigationDelegate: class, WKNavigationDelegate {
    
    var didValidateCallback: () -> Void { get  set }
    var didFinishNavigation: () -> Void { get set }
    
    func isValidCallback(for urlResponse: URLResponse?) -> Bool
    
}

class AuthPermissionWebKitNavigation: NSObject, AuthPermissionWebKitNavigationDelegate {
    
    var didValidateCallback: () -> Void
    var didFinishNavigation: () -> Void
    
    // MARK: - Initializers
    
    init(didValidateCallback: @escaping () -> Void, didFinishNavigation: @escaping () -> Void) {
        self.didValidateCallback = didValidateCallback
        self.didFinishNavigation = didFinishNavigation
    }
    
    // MARK: - WKNavigationDelegate
    
    func isValidCallback(for urlResponse: URLResponse?) -> Bool {
        guard let response = urlResponse as? HTTPURLResponse,
            let headers = response.allHeaderFields as? [String: Any],
            let callback = headers["authentication-callback"] as? String else {
                return false
        }
        print(callback)
        return true
    }
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if isValidCallback(for: navigationResponse.response) {
            didValidateCallback()
        }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        didFinishNavigation()
    }
    
}
