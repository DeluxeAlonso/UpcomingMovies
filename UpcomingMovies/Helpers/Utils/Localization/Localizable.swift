//
//  Localizable.swift
//  UpcomingMovies
//
//  Created by Alonso on 22/01/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

protocol Localizable {

    var tableName: String { get }
    var localized: String { get }

}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {

    var tableName: String {
        "Localizable"
    }

    var localized: String {
        rawValue.localized(tableName: tableName)
    }

    func callAsFunction() -> String {
        self.localized
    }

}
