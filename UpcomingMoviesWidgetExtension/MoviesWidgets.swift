//
//  MovieWidgets.swift
//  UpcomingMoviesWidgetExtension
//
//  Created by Alonso on 11/21/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import WidgetKit
import SwiftUI

@main
struct MoviesWidgets: WidgetBundle {
    var body: some Widget {
        UpcomingMoviesWidget()
        SearchMoviesWidget()
    }
}

struct UpcomingMoviesWidget_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingMoviesWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
