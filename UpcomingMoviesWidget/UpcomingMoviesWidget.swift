//
//  UpcomingMoviesWidget.swift
//  UpcomingMoviesWidget
//
//  Created by Alonso on 11/21/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

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

@main
struct UpcomingMoviesWidget: Widget {
    let kind: String = "UpcomingMoviesWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            UpcomingMoviesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
    }
}

struct UpcomingMoviesWidget_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingMoviesWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
