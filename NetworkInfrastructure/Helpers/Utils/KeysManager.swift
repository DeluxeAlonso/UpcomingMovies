//
//  KeysManager.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 11/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

class KeysManager: NSObject {
    
    class func retrieveKeys() -> Keys {
        let bundle = Bundle(for: self.classForCoder())
        guard let url = bundle.url(forResource: "TheMovieDb", withExtension: ".plist") else {
            fatalError()
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let plist = try decoder.decode([String: Keys].self, from: data)
            guard let keys = plist["Keys"] else { fatalError() }
            return keys
        } catch {
            fatalError()
        }
    }
    
}
