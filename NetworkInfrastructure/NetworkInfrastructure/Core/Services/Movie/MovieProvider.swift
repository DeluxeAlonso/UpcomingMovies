//
//  MovieProvider.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 11/10/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

enum MovieProvider {

    case getUpcoming(page: Int)
    case getPopular(page: Int)
    case getTopRated(page: Int)
    case getByGenreId(page: Int, genreId: Int)
    case search(searchText: String, includeAdult: Bool)
    case getDetail(id: Int)
    case getVideos(id: Int)
    case getReviews(page: Int, id: Int)
    case getSimilars(page: Int, id: Int)
    case getCredits(id: Int)
    case getAccountState(id: Int, sessionId: String)
    case rateMovie(id: Int, sessionId: String, value: Double)

}

// MARK: - Endpoint

extension MovieProvider: Endpoint {

    var base: String {
        NetworkConfiguration.shared.baseAPIURLString
    }

    var path: String {
        switch self {
        case .getUpcoming:
            return "/3/movie/upcoming"
        case .getPopular:
            return "/3/movie/popular"
        case .getTopRated:
            return "/3/movie/top_rated"
        case .getByGenreId:
            return "/3/discover/movie"
        case .search:
            return "/3/search/movie"
        case .getDetail(let id):
            return "/3/movie/\(id)"
        case .getVideos(let id):
            return "/3/movie/\(id)/videos"
        case .getReviews(_, let id):
            return "/3/movie/\(id)/reviews"
        case .getSimilars(_, let id):
            return "/3/movie/\(id)/similar"
        case .getCredits(let id):
            return "/3/movie/\(id)/credits"
        case .getAccountState(let id, _):
            return "/3/movie/\(id)/account_states"
        case .rateMovie(let id, _, _):
            return "/3/movie/\(id)/rating"
        }
    }

    var headers: [String: String]? {
        nil
    }

    var params: [String: Any]? {
        switch self {
        case .getUpcoming(let page):
            return ["page": page]
        case .getPopular(let page):
            return ["page": page]
        case .getTopRated(let page):
            return ["page": page]
        case .getByGenreId(let page, let genreId):
            return ["page": page,
                    "with_genres": genreId,
                    "sort_by": "release_date.desc"]
        case .search(let searchText, let includeAdult):
            return ["query": searchText, "include_adult": includeAdult]
        case .getDetail, .getVideos, .getCredits:
            return nil
        case .getReviews(let page, _):
            return ["page": page]
        case .getSimilars(let page, _):
            return ["page": page]
        case .getAccountState( _, let sessionId):
            return ["session_id": sessionId]
        case .rateMovie(_, _, let value):
            return ["value": value]
        }
    }

    var parameterEncoding: ParameterEnconding {
        switch self {
        case .getAccountState, .getByGenreId, .getCredits, .getDetail, .getPopular, .getReviews,
             .getSimilars, .getTopRated, .getUpcoming, .getVideos, .search:
            return .defaultEncoding
        case .rateMovie:
            return .jsonEncoding
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getAccountState, .getByGenreId, .getCredits, .getDetail, .getPopular, .getReviews,
             .getSimilars, .getTopRated, .getUpcoming, .getVideos, .search:
            return .get
        case .rateMovie:
            return .post
        }
    }

}
