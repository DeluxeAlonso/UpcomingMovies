//
//  MovieVisitProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 15/07/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import Foundation

protocol MovieVisitProtocol {

    var id: Int { get }
    var title: String { get }
    var posterPath: String { get }
    var createdAt: Date? { get }

}
