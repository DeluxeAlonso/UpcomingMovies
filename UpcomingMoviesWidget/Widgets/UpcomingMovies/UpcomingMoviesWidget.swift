//
//  UpcomingMoviesWidget.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/25/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import SwiftUI
import WidgetKit

struct UpcomingMoviesWidgetEntryView: View {
    var entry: Provider.Entry

    let gradientColors = [.white, Color("GradientColor"), Color("GradientColor")]

    var body: some View {
        Group {
            VStack(alignment: .center, spacing: 16) {
                Image(systemName: "play")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                    .padding(25)
                    .background(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .topLeading, endPoint: .bottomTrailing))
                Text("Upcoming")
                    .font(.system(size: 13))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BackgroundColor"))
    }
}

struct UpcomingMoviesWidget: Widget {
    let kind: String = "UpcomingMoviesWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            UpcomingMoviesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Upcoming movies")
        .description("Keep up to date with the latest releases")
        .supportedFamilies([.systemSmall])
    }
}
