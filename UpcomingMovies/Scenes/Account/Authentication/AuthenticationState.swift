//
//  AuthenticationState.swift
//  UpcomingMovies
//
//  Created by Alonso on 18/03/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

enum AuthenticationState {
    case currentlySignedIn, justSignedIn
    case currentlySignedOut, justSignedOut
}

protocol AuthenticationStateDelegate {

    func didUpdateAuthenticationState(_ state: AuthenticationState)

}
