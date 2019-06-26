//
//  CustomListDetailSectionViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class CustomListDetailSectionViewModel {
    
    let movieCountText: String
    var ratingText: String = "-"
    var runtimeText: String = "-"
    
    init(movieCount: Int, rating: Double?, runtime: Int?) {
        movieCountText = "\(movieCount)"
        if let rating = rating { ratingText = "\(rating)" }
        if let runtime = runtime { runtimeText = getRuntimeText(for: runtime) }
    }
    
    func getRuntimeText(for runtime: Int) -> String {
        let hours = runtime / 60
        let minutes = runtime % 60
        return "\(hours)h \(minutes)m"
    }
    
}
