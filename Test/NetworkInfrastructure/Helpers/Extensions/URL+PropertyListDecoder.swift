//
//  URL+PropertyListDecoder.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 5/25/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

extension URL {
    
    func decodePropertyList<T: Decodable>() throws -> T {
        let data = try Data(contentsOf: self)
        let decoder = PropertyListDecoder()
        return try decoder.decode(T.self, from: data)
    }
    
}
