//
//  VideoResult.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/9/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import Domain

public struct VideoResult: Decodable {
    
    let results: [Video]
    
}
