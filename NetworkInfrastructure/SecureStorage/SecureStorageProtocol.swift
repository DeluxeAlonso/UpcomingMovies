//
//  SecureStorageProtocol.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 1/2/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

protocol SecureStorageProtocol {

    /**
     Retrieves the current access token.

     - Returns: Securely stored access token.
     */
    func getAccessToken() -> String?

    /**
     Securely save a new access token.

     - Parameter token: Access token to be securely saved.
     */
    func saveAccessToken(_ token: String?)

    /**
     Retrieves the current user id

     - Returns: Securely stored user id.
     */
    func getCurrentUserId() -> String?

    /**
     Securely save a new user id.

     - Parameter currentUserId: Current user id to be securely saved.
     */
    func saveCurrentUserId(_ currentUserId: String?)

}
