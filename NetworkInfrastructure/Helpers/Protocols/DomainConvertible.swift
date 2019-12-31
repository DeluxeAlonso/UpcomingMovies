//
//  DomainConvertible.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 12/30/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

protocol DomainConvertible {
    
    associatedtype Domain
    
    func asDomain() -> Domain
    
}
