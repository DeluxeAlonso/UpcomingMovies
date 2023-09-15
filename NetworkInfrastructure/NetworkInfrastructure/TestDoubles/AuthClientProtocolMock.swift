//
//  AuthClientProtocolMock.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 14/09/23.
//

import UpcomingMoviesDomain

final class AuthClientProtocolMock: AuthClientProtocol {

    var getRequestTokenResult: Result<RequestTokenResult, APIError>?
    private(set) var getRequestTokenCallCount = 0
    func getRequestToken(with readAccessToken: String, completion: @escaping (Result<RequestTokenResult, APIError>) -> Void) {
        if let getRequestTokenResult = getRequestTokenResult {
            completion(getRequestTokenResult)
        }
        getRequestTokenCallCount += 1
    }

    var getAccessTokenResult: Result<AccessToken, APIError>?
    private(set) var getAccessTokenCallCount = 0
    func getAccessToken(with readAccessToken: String, requestToken: String, completion: @escaping (Result<AccessToken, APIError>) -> Void) {
        if let getAccessTokenResult = getAccessTokenResult {
            completion(getAccessTokenResult)
        }
        getAccessTokenCallCount += 1
    }

    var createSessionIdResult: Result<SessionResult, APIError>?
    private(set) var createSessionIdCallCount = 0
    func createSessionId(with accessToken: String, completion: @escaping (Result<SessionResult, APIError>) -> Void) {
        if let createSessionIdResult = createSessionIdResult {
            completion(createSessionIdResult)
        }
        createSessionIdCallCount += 1
    }

}
