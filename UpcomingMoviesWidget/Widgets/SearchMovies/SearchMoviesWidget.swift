//
//  SearchMoviesWidget.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/25/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import SwiftUI
import WidgetKit

struct SearchMoviesWidget: Widget {
    let kind: String = "SearchMoviesWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            UpcomingMoviesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Search movies")
        .description("Search your favorit movies")
        .supportedFamilies([.systemSmall])
    }
}
