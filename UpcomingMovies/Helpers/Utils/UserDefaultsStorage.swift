//
//  UserDefaultsStorage.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/02/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import Foundation

@propertyWrapper
struct UserDefaultsStorage<T> {

    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }

}
