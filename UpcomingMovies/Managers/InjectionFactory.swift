//
//  InjectionFactory.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/1/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import Domain
import CoreDataPlatform

final class InjectionFactory {
    
    class func useCaseProvider() -> UseCaseProviderProtocol {
        return UseCaseProvider()
    }
    
}
