//
//  URL+PropertyListDecoder.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/6/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

import Foundation

extension URL {

    func decodePropertyList<T: Decodable>() throws -> T {
        let data = try Data(contentsOf: self)
        let decoder = PropertyListDecoder()
        return try decoder.decode(T.self, from: data)
    }

}
