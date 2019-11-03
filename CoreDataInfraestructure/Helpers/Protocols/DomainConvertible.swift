//
//  DomainConvertible.swift
//  CoreDataInfraestructure
//
//  Created by Alonso on 10/26/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

protocol DomainConvertible {
    
    associatedtype Domain
    
    func asDomain() -> Domain
    
}
