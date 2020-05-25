//
//  ConfigurationHandler.swift
//  UpcomingMovies
//
//  Created by Alonso on 5/24/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

class ConfigurationHandler {
    
    static let shared: ConfigurationHandler = ConfigurationHandler()
    
    private var configuration: Configuration?
    
    init() {}
    
    func setConfiguration(_ configuration: Configuration) {
        self.configuration = configuration
    }
    
}
