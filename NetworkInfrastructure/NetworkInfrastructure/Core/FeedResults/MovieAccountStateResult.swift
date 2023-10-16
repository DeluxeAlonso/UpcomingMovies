//
//  MovieAccountStateResult.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/6/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

struct MovieAccountStateResult: Decodable {

    let id: Int
    let favorite: Bool
    let watchlist: Bool

}
