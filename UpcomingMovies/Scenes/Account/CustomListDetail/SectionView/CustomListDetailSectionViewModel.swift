//
//  CustomListDetailSectionViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

protocol CustomListDetailSectionViewModelProtocol {

    var movieCountText: String { get }
    var ratingText: String { get }
    var runtimeText: String { get }
    var revenueText: String { get }

}

final class CustomListDetailSectionViewModel: CustomListDetailSectionViewModelProtocol {

    let movieCountText: String
    var ratingText: String = "-"
    var runtimeText: String = "-"
    var revenueText: String = "-"

    private lazy var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()

    init(list: List) {
        movieCountText = "\(list.movieCount)"
        if let rating = list.averageRating { ratingText = "\(getTruncatedRating(rating))" }
        if let runtime = list.runtime { runtimeText = getRuntimeText(for: runtime) }
        if let revenue = list.revenue { revenueText = getRevenueText(revenue: revenue) ?? "-" }
    }

    private func getRuntimeText(for runtime: Int) -> String {
        let hours = runtime / 60
        let minutes = runtime % 60
        return "\(hours)h \(minutes)m"
    }

    private func getTruncatedRating(_ rating: Double) -> Double {
        Double(floor(rating * 100) / 100)
    }

    private func getRevenueText(revenue: Double) -> String? {
        let num = abs(revenue)
        let sign = (revenue < 0) ? "-" : ""

        switch num {
        case 1_000_000...:
            return "$\(sign)\((num / 1_000_000).reduceScale(to: 1))M"
        case 1_000...:
            return "$\(sign)\((num / 1_000).reduceScale(to: 1))K"
        case 0...:
            return "$\(revenue)"
        default:
            return "$\(sign)\(revenue)"
        }
    }

}

extension Double {

    func reduceScale(to places: Int) -> Double {
        let multiplier = pow(10, Double(places))
        let newDecimal = multiplier * self // move the decimal right
        let truncated = Double(Int(newDecimal)) // drop the fraction
        let originalDecimal = truncated / multiplier // move the decimal back
        return originalDecimal
    }

}
