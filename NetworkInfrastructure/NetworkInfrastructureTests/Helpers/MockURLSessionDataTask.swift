//
//  MockURLSessionDataTask.swift
//  NetworkInfrastructure-Unit-NetworkInfrastructureTests
//
//  Created by Alonso on 21/08/23.
//

import Foundation

final class MockURLSessionDataTask: URLSessionDataTask {

    private(set) var resumeCallCount = 0
    override func resume() {
        resumeCallCount += 1
    }

}
