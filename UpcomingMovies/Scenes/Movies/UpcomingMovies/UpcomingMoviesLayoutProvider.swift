//
//  UpcomingMoviesLayoutProvider.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/04/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import UIKit

struct UpcomingMoviesLayoutProvider: UpcomingMoviesLayoutProviderProtocol {

    func collectionViewLayout(for presentationMode: UpcomingMoviesPresentationMode, and collectionViewWidth: CGFloat) -> UICollectionViewLayout {
        switch presentationMode {
        case .detail:
            let detailLayoutWidth = collectionViewWidth - Constants.detailCellOffset
            return VerticalFlowLayout(preferredWidth: detailLayoutWidth, preferredHeight: Constants.detailCellHeight)
        case .preview:
            let previewLayoutWidth = Constants.previewCellHeight / CGFloat(UIConstants.posterAspectRatio)
            return VerticalFlowLayout(preferredWidth: previewLayoutWidth,
                                      preferredHeight: Constants.previewCellHeight,
                                      minColumns: Constants.previewLayoutMinColumns)
        }
    }

    struct Constants {

        static let previewCellHeight: CGFloat = 150.0

        static let detailCellHeight: CGFloat = 200.0
        static let detailCellOffset: CGFloat = 32.0

        static let previewLayoutMinColumns: Int = 3

    }

}
