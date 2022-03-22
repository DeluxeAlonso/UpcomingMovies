//
//  SmallWidgetView.swift
//  UpcomingMoviesWidgetExtension
//
//  Created by Alonso on 11/25/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import SwiftUI

struct SmallWidgetView: View {

    let title: Text
    let iconName: String
    let gradientColors: [Color]
    let backgroundColor: Color

    var body: some View {
        GeometryReader { geometry in
            Group {
                VStack(alignment: .center, spacing: 16) {
                    Image(systemName: iconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 25, maxHeight: 25)
                        .foregroundColor(.white)
                        .padding(geometry.size.height * 0.15)
                        .background(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .topLeading, endPoint: .bottomTrailing))
                    title
                        .font(.system(size: 13))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(backgroundColor)
        }
    }

}
