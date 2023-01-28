//
//  String+Localized.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/3/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

extension String {

    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        NSLocalizedString(self,
                          tableName: tableName,
                          bundle: bundle,
                          value: self,
                          comment: "")
    }

}
