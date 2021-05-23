//
//  Result+Optional.swift
//  UpcomingMovies
//
//  Created by Alonso on 23/05/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

import Foundation

extension Result {

    func getWrappedValue() -> Success? {
        return try? get()
    }

}
