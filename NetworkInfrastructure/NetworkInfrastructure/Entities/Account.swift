//
//  Account.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 24/10/21.
//

import Foundation

public struct Account {

    public let accountId: Int
    public let sessionId: String

    public init(accountId: Int, sessionId: String) {
        self.accountId = accountId
        self.sessionId = sessionId
    }

}
