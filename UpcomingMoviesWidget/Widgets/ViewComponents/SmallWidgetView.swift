//
//  SmallWidgetView.swift
//  UpcomingMoviesWidgetExtension
//
//  Created by Alonso on 11/25/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import SwiftUI

struct SmallWidgetView: View {
    let title: String
    let iconName: String
    let gradientColors: [Color]

    var body: some View {
        Group {
            VStack(alignment: .center, spacing: 16) {
                Image(systemName: iconName)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                    .padding(25)
                    .background(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .topLeading, endPoint: .bottomTrailing))
                Text(title)
                    .font(.system(size: 13))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BackgroundColor"))
    }
}
