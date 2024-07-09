//
//  MovieSearchProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/07/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import Foundation

protocol MovieSearchProtocol {
    var id: String { get }
    var searchText: String { get }
    var createdAt: Date { get }
}
