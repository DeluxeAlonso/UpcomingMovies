//
//  SearchMoviesWidget.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/25/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import SwiftUI
import WidgetKit

struct SearchMoviesWidgetEntryView: View {
    var entry: Provider.Entry

    let gradientColors = [.white, Color("GradientColor"), Color("GradientColor")]

    var body: some View {
        SmallWidgetView(title: "Search",
                        iconName: "magnifyingglass",
                        gradientColors: gradientColors)
    }
}

struct SearchMoviesWidget: Widget {
    let kind: String = "SearchMoviesWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            SearchMoviesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Search movies")
        .description("Search your favorite movies")
        .supportedFamilies([.systemSmall])
    }
}
