//
//  RangeReplaceableCollection+Extensions.swift
//  UpcomingMovies
//
//  Created by Alonso on 19/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import Foundation

extension RangeReplaceableCollection {

    mutating func removeLast(while predicate: (Element) throws -> Bool) rethrows {
        guard let index = try indices.reversed().first(where: { try !predicate(self[$0]) }) else {
            removeAll()
            return
        }
        removeSubrange(self.index(after: index)...)
    }

}
