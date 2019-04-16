//
//  URLRequest+Extensions.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/16/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

extension URLRequest {
    
    mutating func setJSONContentType() {
        setValue("application/json; charset=utf-8",
                 forHTTPHeaderField: "Content-Type")
    }
    
}
