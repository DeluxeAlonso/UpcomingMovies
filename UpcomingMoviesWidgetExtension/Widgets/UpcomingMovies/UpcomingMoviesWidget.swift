//
//  UpcomingMoviesWidget.swift
//  UpcomingMoviesWidgetExtension
//
//  Created by Alonso on 11/25/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import SwiftUI
import WidgetKit

struct UpcomingMoviesWidgetEntryView: View {
    
    private let gradientColors = [.white,
                                  Color("UpcomingMoviesGradientColor"),
                                  Color("UpcomingMoviesGradientColor")]
    
    private let backgroundColor = Color("UpcomingMoviesBackgroundColor")

    var entry: Provider.Entry
    
    var body: some View {
        SmallWidgetView(title: "Upcoming",
                        iconName: "play",
                        gradientColors: gradientColors,
                        backgroundColor: backgroundColor)
            .widgetURL(AppExtension.url(for: .upcomingMovies))
    }

}

struct UpcomingMoviesWidget: Widget {

    private let kind: String = "UpcomingMoviesWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            UpcomingMoviesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Upcoming movies")
        .description("Keep up to date with the latest releases")
        .supportedFamilies([.systemSmall])
    }
    
}
