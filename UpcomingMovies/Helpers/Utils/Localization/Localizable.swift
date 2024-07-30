//
//  Localizable.swift
//  UpcomingMovies
//
//  Created by Alonso on 22/01/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

protocol Localizable {

    var tableName: String { get }

}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {

    var tableName: String {
        "Localizable"
    }

    func callAsFunction() -> String {
        rawValue.localized(tableName: tableName)
    }

}
