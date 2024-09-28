//
// Auto-generated code. Do not modify this file manually.
//

import Foundation

protocol Localizable {
    var tableName: String { get }
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    var tableName: String {
        "Localizable"
    }

    func callAsFunction() -> String {
        rawValue.localized(tableName: tableName)
    }
}

private extension String {
    func localized(bundle: Bundle = .main,
                   tableName: String,
                   comment: String = "") -> String {
        NSLocalizedString(self, tableName: tableName, value: self, comment: comment)
    }
}

enum LocalizedStrings: String, Localizable {
    case upcomingMoviesTabBarTitle
	case upcomingMoviesTitle
	case searchMoviesTabBarTitle
	case searchMoviesTitle
	case recentSearches
	case emptySearchResults
	case recentlyVisitedSeearchSectionTitle
	case movieGenresSearchSectionTitle
	case favoritesTabBarTitle
	case favoritesTitle
	case accountTabBarTitle
	case accountTitle
	case favoritesCollectionOption
	case watchlistCollectionOption
	case customListGroupOption
	case recomendedMoviesOption
	case includeAdults
	case signIn
	case signOutConfirmationTitle
	case signOut
	case emptyMovieResults
	case emptyVideoResults
	case emptyCreditResults
	case emptyReviewResults
	case movieDetailTitle
	case movieDetailShareActionTitle
	case movieDetailShareText
	case reviewsDetailOptions
	case trailersDetailOptions
	case creditsDetailOptions
	case similarsDetailOptions
	case movieCreditAccessibility
	case addToFavoritesHint
	case removeFromFavoritesHint
	case addToFavoritesSuccess
	case removeFromFavoritesSuccess
	case addToWatchlistHint
	case removeFromWatchlistHint
	case addToWatchlistSuccess
	case removeFromWatchlistSuccess
	case expandMovieCellsHint
	case collapseMovieCellsHint
	case topRatedMoviesTitle
	case topRatedMoviesSubtitle
	case popularMoviesTitle
	case popularMoviesSubtitle
	case similarMoviesTitle
	case cast
	case crew
	case ratingHint
	case cancel
	case shareMovieActionSheetItemTitle
	case upcomingMoviesSmallWidgetTitle
	case upcomingMoviesWidgetDescription
	case searchMoviesSmallWidgetTitle
	case searchMoviesWidgetDescription
	case movieListRecommendationsTitle
	case movieListCellGenreTitle
	case movieListCellReleaseDateTitle
	case customListDetailSectionMovieCountTitle
	case customListDetailSectionRatingTitle
	case customListDetailSectionRuntimeTitle
	case customListDetailSectionRevenueTitle
	case errorPlaceHolderViewTitleText
	case errorPlaceHolderViewDetailText
	case errorPlaceHolderViewRetryButtonTitle
}
