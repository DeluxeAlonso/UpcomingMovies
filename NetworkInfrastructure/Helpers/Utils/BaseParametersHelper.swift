//
//  KeysManager.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 11/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class BaseParametersHelper: NSObject {
    
    static let shared = BaseParametersHelper()
    
    private lazy var baseParameters: BaseParameters = {
        let bundle = Bundle(for: Self.classForCoder())
        guard let url = bundle.url(forResource: "BaseParameters", withExtension: ".plist") else {
            fatalError()
        }
        do {
            let baseParameters: BaseParameters = try url.decodePropertyList()
            return baseParameters
        } catch {
            fatalError()
        }
    }()
    
    var baseAPIURLString: String {
        return baseParameters.baseAPIURLString
    }
    
    var readAccessToken: String {
        return baseParameters.keys.readAccessToken
    }
    
    var apiKey: String {
        return baseParameters.keys.apiKey
    }
    
}
