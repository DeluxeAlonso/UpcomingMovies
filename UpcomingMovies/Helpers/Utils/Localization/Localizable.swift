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
        return "Localizable"
    }

    var localized: String {
        return rawValue.localized(tableName: tableName)
    }

    func callAsFunction() -> String {
        return self.localized
    }

}
