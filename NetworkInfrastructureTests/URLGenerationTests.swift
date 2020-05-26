//
//  URLGenerationTests.swift
//  NetworkInfrastructureTests
//
//  Created by Alonso on 5/25/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import XCTest
@testable import NetworkInfrastructure

class URLGenerationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testURLRequestSetJsonContentType() throws {
        //Arrange
        var urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org")!)
        //Act
        urlRequest.setJSONContentType()
        let allHeaderFields = urlRequest.allHTTPHeaderFields
        //Assert
        XCTAssertNotNil(allHeaderFields!["Content-Type"])
    }
    
    func testURLRequestSetJsonContentTypeNil() throws {
        //Arrange
        let urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org")!)
        //Act
        let allHeaderFields = urlRequest.allHTTPHeaderFields
        //Assert
        XCTAssertNil(allHeaderFields)
    }

}
