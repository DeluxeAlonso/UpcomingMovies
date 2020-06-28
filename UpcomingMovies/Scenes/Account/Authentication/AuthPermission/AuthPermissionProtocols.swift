//
//  AuthPermissionProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import WebKit

protocol AuthPermissionViewModelProtocol {
    
    var authPermissionURLRequest: URLRequest? { get }
    
}

protocol AuthPermissionCoordinatorProtocol: class {
    
    func dismiss(completion: (() -> Void)?)
    func didDismiss()
    
}

protocol AuthPermissionWebViewNavigationDelegate: class, WKNavigationDelegate {
    
    var didValidateCallback: () -> Void { get set }
    var didFinishNavigation: () -> Void { get set }
    
    func isValidCallback(for urlResponse: URLResponse?) -> Bool
    
}
