//
//  Array+MidElement.swift
//  UpcomingMovies
//
//  Created by Alonso on 5/25/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

extension Array {

    var mid: Element? {
        guard count != 0 else { return nil }

        let midIndex = (count > 1 ? count - 1 : count) / 2
        return self[midIndex]
    }

}
